require 'termnote'

include TermNote

show.add chapter title: "Threads", subtitle: "Ruby and some Rails"
show.add chapter title: "Basic Threads", subtitle: "Here Be Dragons"
# Threads are dangerous and should only be used if you know what you are doing
# This lectures is the basic of threading, we won't touch (almost) locking and solutions to problem
# we are presenting what threads are and some of the things around them
show.add text title: "Thread vs. Process", content: <<-CONTENT 
# this is mostly a unix presentation
* Resources
* Control and Manage:
 - Externally (3rd party apps)
 - Restart
 - Memory leaks
 - Self relient
 - Mostly controlled by OS
 - Shared memory sync objects differ
CONTENT
show.add text title: "Rails (and most Ruby) Chose Process", content: <<-CONTENT
* It makes developer’s lives easier
* It makes C extensions development easier
	- Unless you need multi threaded processing
* Most of the C libraries which are wrapped are not thread safe
* Parts of Ruby’s implementation aren’t threadsafe (Hash for instance)
CONTENT
show.add chapter title: "The GIL", subtitle: "Cuncurrency vs. Parallelism"
show.add code language: "Ruby", title: "GIL on irb", source: <<-SOURCE
count = 0

100.times do |i|
   Thread.new {
      count += 1
   }
end

sleep(10)
puts count
SOURCE
show.add code language: "Ruby", title: "No Race Conditions..", source: <<-SOURCE
i = 0
t1 = Thread.new do
  1_000_000.times do
    i += 1
  end
end
t2 = Thread.new do
  1_000_000.times do
    i += 1
  end
end
t1.join
t2.join
puts i
SOURCE
show.add code language: "Ruby", title: "No Race Conditions?", source: <<-SOURCE
i = 0
t1 = Thread.new do
	if i == 0 
		sleep(5)
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
SOURCE
show.add text title: "Some things are excluded", content: <<-CONTENT
* C Libraries
* I/O
CONTENT
show.add text title: "Threads evolve", content: <<-CONTENT
* 1.8: Green Threads (http://en.wikipedia.org/wiki/Green_threads)
* 1.9: - Real Threads (preemptive by OS)
	- Fibers (yield controlled)
		-- Fibonacci
		-- enumerator implemented using fibers
CONTENT
show.add code language: "Ruby", title: "Small fiber example", source: <<-SOURCE
# (c) Avdi Grim
def names
  yield "Ylva"
  yield "Brighid"
  yield "Shifra"
  yield "Yesamin"
end

class MyEnumerator
  def initialize(object, method_name, *args)
    @fiber = Fiber.new do
      object.send(method_name, *args) do |*yielded_values|
        Fiber.yield(*yielded_values)
      end
    end
  end

  def next
    @fiber.resume
  end
end

enum = MyEnumerator.new(self, :names)
enum.next                       # => "Ylva"
enum.next                       # => "Brighid"
SOURCE
show.add code language: "Ruby", title: "Let's try", source: <<-SOURCE
class Test
  ITERATIONS = 1000

  def run_threads
    start = Time.now
    threads = []

    20.times do
      threads << Thread.new do
        do_iterations
      end
    end

    threads.each {|t| t.join } # also can be written: threads.each &:join

    puts Time.now - start
  end

  def run_normal
    start = Time.now

    20.times do
      do_iterations
    end

    puts Time.now - start
  end

  def do_iterations
    1.upto ITERATIONS do |i|
      999.downto(1).inject(:*) # 999!
    end
  end
end

t = Test.new

t.run_threads
t.run_normal
SOURCE
show.add code language: "Ruby", title: "Add Some Sleep", source: <<-SOURCE
class Test
  ITERATIONS = 1000

  def run_threads
    start = Time.now
    threads = []

    20.times do
      threads << Thread.new do
        do_iterations
      end
    end

    threads.each {|t| t.join } # also can be written: threads.each &:join

    puts Time.now - start
  end

  def run_normal
    start = Time.now

    20.times do
      do_iterations
    end

    puts Time.now - start
  end

  def do_iterations
    sleep(10)
  end
end

t = Test.new

t.run_threads
t.run_normal
SOURCE
show.add code language: "Ruby", title: "Let's Fork It", source: <<-SOURCE
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

    puts Time.now - start
  end

	def run_forks
    start = Time.now

    10.times do
      fork do
        do_iterations
      end
    end
    Process.waitall

    puts Time.now - start
  end

  def run_normal
    start = Time.now

    10.times do
      do_iterations
    end

    puts Time.now - start
  end

  def do_iterations
    1.upto ITERATIONS do |i|
      999.downto(1).inject(:*) # 999!
    end
  end
end

t = Test.new

t.run_threads
t.run_forks
t.run_normal
SOURCE
show.add text title: "Issues Recap", content: <<-CONTENT
* Ruby not thread safe
* No real Parallelism
* Your code needs to be protected
CONTENT
show.add chapter title: "Why Threads?", subtitle: "Here Be BIG Dragons"
#threads are light weight, concurrent processing units. Sometimes, when there isn't a lot of data sync to be done
#it can be the right thing to do. Also, when work can be assigned to be done later or not on users time: sending email,
#pinging remote API, etc.
#When working with evented web servers, most are thread based and it also makes a lot of sense - using the actor pattern
#will help you work around some of the issues.
show.add text title: "Use Threads", content: <<-CONTENT
* When you need concurrency:
	- you control everything
	- fibers are not enough
CONTENT
show.add text title: "Alternatives?", content: <<-CONTENT
CONTENT
show.start
