class Cryptobot < ApplicationRecord 
	INTEREST = ['USDT_BTC', 'USDT_ETH','USDT_XMR', 'USDT_LTC', 'USDT_ZEC', 'BTC_XMR', 'BTC_ETH', 'BTC_LTC', 'BTC_ZEC', 'ETH_ZEC']
	
	def self.tiker
		@tickerData = []
		tickerData = JSON.parse(PoloniexRuby.ticker.to_json)
		tickerData["data"].each.with_index do |assetpair, i|
			if INTEREST.include? "#{assetpair[0]}"
				current_price = assetpair[1]["last"].to_f
				ref_bot = Cryptobot.where(:assetpair => assetpair[0]).last
				pricedelta = if ref_bot.present? then (current_price - ref_bot[:price].to_f)*100/ref_bot[:price].to_f else current_price end
				optim_weight_record = Cryptobot.where(assetpair: assetpair[0]).where.not(optim_weight: nil).last
				if optim_weight_record.present?
					initial_weight = optim_weight_record[:optim_weight].to_f
				else
					initial_weight = 1.0/(INTEREST.count)
				end
				@tickerData << Cryptobot.new(:assetpair => assetpair[0], :time => Time.zone.now.to_i, :price => assetpair[1]["last"].to_f, :pricedelta => pricedelta, :initial_weight => initial_weight)
			end
		end
		Cryptobot.import @tickerData
	end

	def self.indikator
		INTEREST.each do |ap|
			@inputs = []
			@add_sma_to_records = Cryptobot.where(assetpair: ap).last(INTEREST.count).each do |h|
				@inputs << h[:price]
			end
			params = if @inputs.count < 2 then 1 else 2 end
			@sma = Indicators::Data.new(@inputs).calc(:type => :sma, :params => params).output
			@ema = Indicators::Data.new(@inputs).calc(:type => :ema, :params => params).output
			@sma.zip(@ema).map do |sma, ema|
				Cryptobot.where(id: Cryptobot.where(assetpair: ap).last[:id]).update_all(sma: sma, ema: ema)
			end
		end
	end

	def self.optimize
		@initial_weights, @optim_weights, @prices, @ids, @price_deltas, @times, @lb, @ub  = Array.new(8) { []  }
		@records_to_be_updated = Cryptobot.last(INTEREST.count)

		@records_to_be_updated.each do |h|
			@initial_weights << h[:initial_weight].to_f
			@ids << h[:id]
			@prices << h[:price].to_f
			@times << h[:time]
			@price_deltas << h[:pricedelta].to_f
			@lb << 0.000001
			@ub << 0.3
		end

		r = RinRuby.new 

		r.assign "assetpairs", INTEREST
		r.assign "prices", @prices
		r.assign "initial_weights", @initial_weights
		r.assign "lb", @lb
		r.assign "ub", @ub

		r.eval <<-EOF
			suppressMessages(library(Rsolnp))
			max_f <- function(assetpairs){
				-sum(assetpairs * prices)
			}
			equal_f <- function(assetpairs) {
			  sum(assetpairs)
			}
			sol <- gosolnp(fun=max_f, eqfun=equal_f, eqB=1, LB=lb, UB=ub)
			optim_weights <- sol$pars
		EOF

		@optim_weights = r.pull "optim_weights"
		order(@records_to_be_updated, @initial_weights, @optim_weights, @price_deltas)
	end

	def self.order(records, initial_weights, optim_weights, price_deltas)
		records.zip(initial_weights, optim_weights, price_deltas).map do |record, initial_weight, optim_weight, pricedelta| 
			order = if pricedelta < -0.1 then 'BUY' elsif pricedelta > 0.1 then 'SELL' else 'HOLD' end
			#taker
			amount = if order!= "HOLD" then (1-0.25)*(optim_weight - initial_weight) else 0 end
			#maker
			#amount = (1-0.15)*(optim_weight - initial_weight)
			Cryptobot.where(id: record[:id]).update_all(optim_weight: optim_weight, order: order, amount: amount)
		end
	end
end
