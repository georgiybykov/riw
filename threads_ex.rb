# Load CPU:

Benchmark.realtime { (0..10000000).to_a.shuffle!.take(10000) }
#=> 0.7709245270234533 

Benchmark.realtime do
  Thread.new do
    (0..10000000).to_a.shuffle!.take(10000)
  end
end
#=> 0.00011511699995025992

#######

# Database access (i/o bound):

Benchmark.realtime do
  Thread.new do
    100.times do |n|
      Order.find_by(id: n)
      
      ActiveRecord::Base.clear_active_connections!
    end
  end
end
#=> 3.6922021536156535e-05

Benchmark.realtime do
  100.times do |n|
    Order.find_by(id: n)
  end  
end
#=> 0.13807300699409097

