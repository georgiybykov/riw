# Load CPU:

Benchmark.realtime { (0..10000000).to_a.shuffle!.take(10000) }
#=> 0.9109946360113099 

Benchmark.realtime do
  Thread.new do
    (0..10000000).to_a.shuffle!.take(10000)
  end.join
end
#=> 0.8999259299598634 

#######

# Database access (i/o bound):

Benchmark.realtime do
  100.times do |n|
    Thread.new do
      Order.find_by(id: n)
    
      ActiveRecord::Base.clear_active_connections!
    end.join
  end
end
#=> 0.42176513298181817

Benchmark.realtime do
  100.times do |n|
    Order.find_by(id: n)
  end  
end
#=> 0.3844286390230991
