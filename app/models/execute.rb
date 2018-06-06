class Execute < ApplicationRecord
	def self.setOne
		Cryptobot.tiker
		Cryptobot.indikator
		Cryptobot.optimize
		Portfolio.create
	end
end
