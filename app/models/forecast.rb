class Forecast < ApplicationRecord
	def self.data
		r = RinRuby.new(false)
		@records = []
		Cryptobot::INTEREST.each do |ap|
			@prices, @times, @aps = Array.new(3) { []  }			
			@forecast_records = Cryptobot.where(assetpair: ap).last(2*Cryptobot::INTEREST.count).each do |h|
				@prices << h[:price].to_f
				@times << h[:time]
				@aps << h[:assetpair]
			end

			r.assign "prices", @prices
			r.assign "end", @prices[-1]
			r.assign "start", @prices[0]

			r.eval <<-EOF
				library(forecast)
				prices_data <- ts(prices, freq=24*60)

				tbats_fit <- tbats(prices_data)				
				tbats_components_df <- as.data.frame(tbats.components(tbats_fit))
				tbats_current <- (tbats_components_df[,1])
				tbats_forecasts_df <- data.frame(forecast(tbats_fit, h=5))
				tbats_pointForecasts <- tbats_forecasts_df[,3]
			EOF

			tbats_current_data = r.pull "tbats_current"
			nn_current_data = r.pull "nn_current"

			#refaktor
			if tbats_current_data.is_a? (Array)
				@tbats_current = tbats_current_data
			else 
				@tbats_current = []
				@tbats_current << tbats_current_data
			end

			@tbats_pointForecasts = r.pull "tbats_pointForecasts"

			@tbats = @tbats_current + @tbats_pointForecasts

			@times << @times[-1]+60 << @times[-1]+120  << @times[-1]+180 << @times[-1]+240 << @times[-1]+300

			5.times do 
				@aps << @aps[-1]
			end

			@aps.zip(@times, @tbats).map do |ap, time, tbats|
				unless Forecast.exists?(assetpair: ap, time: time)
					@records << Forecast.new(assetpair: ap, time: time, tbats: tbats)
				end
			end
		end
		Forecast.import @records
	end
end
