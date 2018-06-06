class Ref < ApplicationRecord
	INTEREST = ['BTC_ETH', 'BTC_XMR', 'BTC_ZEC', 'BTC_LTC', 'USDT_BTC', 'USDT_ETH', 'USDT_XMR', 'USDT_ZEC', 'USDT_LTC']
	def self.tiker
		tickerData = JSON.parse(PoloniexRuby.ticker.to_json)

		
		

	end
end
