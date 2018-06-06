class PortfolioController < ApplicationController
	 before_action :global
  def global
    @interest = Cryptobot::INTEREST
  end
	def poketvalue
    @delta = []
    Cryptobot.last(Cryptobot::INTEREST.count).each do |h|
      @delta << [h[:assetpair], h[:time], h[:pricedelta], h[:order], h[:initial_weight], h[:optim_weight], h[:amount]]
    end
    
    @pv = []
    @poket = []

  	Portfolio.where.not(:poket_value => nil).last(60).each do |h|
  		@pv << [h[:time]*1000, h[:poket_value].to_f]
  	end

    Portfolio.last(Cryptobot::INTEREST.count).each do |h|
      @poket << [h[:assetpair], h[:poket].to_f]
    end

    @dataset = [@pv, @poket]
  	respond_to do |format|
      format.html 
      format.json { render json: @dataset}
    end	
  end
end
