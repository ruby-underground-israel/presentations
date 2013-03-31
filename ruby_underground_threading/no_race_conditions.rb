i = 0
t1 = Thread.new do
	if i == 0 
		i += 1
	end
end
t2 = Thread.new do
	if i == 0
		i += 1
	end
end
t1.join
t2.join
puts i