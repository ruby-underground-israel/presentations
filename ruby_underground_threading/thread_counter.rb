count = 0

100.times do |i|
   Thread.new {
   		puts "Thread #{i} is running"
      count += 1
   }
end

sleep(10)
puts "count = #{count}"