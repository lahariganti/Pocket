class Portfolio < ApplicationRecord
	def self.create
		@records = []
		@prices = []
		@all_initial_weights = []
		@all_optim_weights = []
		@all_but_sell_optim_weights = []

		Cryptobot.last(Cryptobot::INTEREST.count).each do |h|
			optim = if h[:order] != "HOLD" then h[:optim_weight] else h[:initial_weight] end
			@all_optim_weights << optim
			@all_initial_weights << h[:initial_weight]
			@prices << h[:price]
			if h[:order] != "SELL"
				@all_but_sell_optim_weights << h[:optim_weight]
			end
		end

		weight_sum =  @all_but_sell_optim_weights.reduce(0, :+)
		@total_optim = @prices.zip(@all_optim_weights).map{|x,y|x*y}
		@total_initial = @prices.zip(@all_initial_weights).map{|x,y|x*y}
		bots = Cryptobot.last(Cryptobot::INTEREST.count)
		bots.each do |h|
			if bots.find_index(h) == (Cryptobot::INTEREST.count - 1)
				value = (@total_optim.inject(:+) - @total_initial.inject(:+))/(@total_initial.inject(:+))
				@records << Portfolio.new(:assetpair => h[:assetpair], :time => h[:time], :poket => (weight_sum*h[:optim_weight]), :poket_value => value)
			else
				@records << Portfolio.new(:assetpair => h[:assetpair], :time => h[:time], :poket => (weight_sum.*h[:optim_weight]))
	    end
	  end
    Portfolio.import @records
	end
end
