count = 0

100.times do |i|
   Thread.new {
   		1000.times do
      	count += 1
      end
   }
end

sleep(3)
puts count