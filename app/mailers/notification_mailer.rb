class NotificationMailer < ApplicationMailer
  def notify_price_change(arg)
    @name = arg[0][:name]
    price_f = arg[0][:price]
    @time_f = Time.at(arg[0][:time]).strftime('%c')
    ref = Cryptobot.where(:name => @name).where.not(:price => nil).last(1)
    price_i = ref[0][:price]
    @time_i = Time.at(ref[0][:time]).strftime('%c')
    @abs_delta = (100*((price_f/100)-(price_i/100))).round(3)
    pp "#{@name}: #{@abs_delta}"
    if @abs_delta < -4
      mail(to: "remotelahari@gmail.com", subject: "#{@name}: #{@abs_delta}%")
    end
  end

  def notify_forecast(arg)
    @name = arg[0][:name]
    arg.last(10).each do |f|
      price_f1 = f[:neuralnet]
      price_f2 = f[:forecast]
      @time_f = Time.at(f[:time]).strftime('%c')
      ref = Cryptobot.where(:name => @name).where.not(:price => nil).last(1)
      price_i = ref[0][:price]
      @time_i = Time.at(ref[0][:time]).strftime('%c')
      @abs_delta1 = (100*((price_f1/100)-(price_i/100))).round(3)
      @abs_delta2 = (100*((price_f2/100)-(price_i/100))).round(3)
      pp "#{@name}: tbats - #{@abs_delta1}: nn - #{@abs_delta2}"
      if @abs_delta1 < -4 && @abs_delta2 < -4
        mail(to: "remotelahari@gmail.com", subject: "#{@name}: tbats - #{@abs_delta1}%: nn - #{@abs_delta2}%").deliver
      end
    end
  end
end
