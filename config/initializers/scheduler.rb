SCHEDULER = Rufus::Scheduler.singleton

m1 = Mutex.new

SCHEDULER.every '60s', :first_in => '10s', :overlap => false, :mutex => m1  do
 Execute.setOne
end

SCHEDULER.every '300s', :first_in => '10s', :overlap => false, :mutex => m1  do
 Forecast.data
end


