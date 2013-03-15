h = {my_value: 1}
threads = []

10.times do 
	threads << Thread.new do
		h[:my_value] += 1
	end
end