#!/usr/bin/env ruby

module Bar
  def foo
    puts "inside Bar"
  end

  def self.prepend_to(klass)
    prepend_features klass
  end
end

class Foo
  def foo
    puts "inside Foo"
  end
end

my_obj = Foo.new
my_obj.foo

Bar.prepend_to Foo
my_obj.foo