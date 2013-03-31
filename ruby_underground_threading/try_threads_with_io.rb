class Test
  ITERATIONS = 1000

  def run_threads
    start = Time.now
    threads = []

    10.times do
      threads << Thread.new do
        do_iterations
      end
    end

    threads.each {|t| t.join } # also can be written: threads.each &:join

    puts "Run threads: #{Time.now - start}"
  end

  def run_normal
    start = Time.now

    10.times do
      do_iterations
    end

    puts "Run threads: #{Time.now - start}"
  end

  def do_iterations
    sleep(5)
  end
end

t = Test.new

t.run_threads
t.run_normal