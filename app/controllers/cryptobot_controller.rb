class CryptobotController < ApplicationController 
  before_action :global

  def global
    @interest = Cryptobot::INTEREST
  end

  def index
    @time = []
    @pricedelta = []
    @dataset = []

    @arg = params[:assetpair]
    @assets = Cryptobot::INTEREST

    Cryptobot.where(:assetpair => @arg).last(60).each do |h|
      @time << h[:time]*1000
      @pricedelta << h[:pricedelta].to_f
    end

    @dataset << {name: @arg, data: @pricedelta}

    @data = {xData: @time.sort, datasets: @dataset.sort}
    respond_to do |format|
      format.html 
      format.json { render json: @data }
    end
  end

  def show
    @price = []
    @tbats = []
    @sma = []
    @ema = []
    @arg = params[:assetpair]
    @assets = []
    @assets << Cryptobot.where(:assetpair => @arg).last[:assetpair] 

    Cryptobot.where(:assetpair => @arg).each do |h|
      @price << [h[:time]*1000, h[:price].to_f]
      @sma << [h[:time]*1000, h[:sma].to_f]
      @ema << [h[:time]*1000, h[:ema].to_f]
    end

    Forecast.where(:assetpair => @arg).each do |h|
      @tbats << [h[:time]*1000, h[:tbats].to_f]
    end
    
    @data = {price: @price.sort{|x,y| x <=> y}, sma: @sma.sort{|x,y| x <=> y}, ema: @ema.sort{|x,y| x <=> y}, tbats: @tbats.sort{|x,y| x <=> y}}
    respond_to do |format|
      format.html 
      format.json { render json: @data }
    end
  end
end
