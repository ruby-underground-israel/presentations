count = 0

100.times do |i|
   Thread.new {
      count += 1
   }
end

sleep(5)
puts count