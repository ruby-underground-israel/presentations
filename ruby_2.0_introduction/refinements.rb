#!/usr/bin/env ruby

# From the refinements spec:
class C
end

module M
  refine C do
    def foo
      puts "C#foo in M"
    end
  end
end

def call_foo(x)
  x.foo
end

using M

x = C.new
x.foo       #=> C#foo in M
call_foo(x) #=> NoMethodError






module StringLength
  refine String do
    def long?
      self.length > 5 ? true : false
    end
  end
end

using StringLength

class StringStuff
  # using StringLength
  def do_something(string)
    if string.long?
      puts "String too long"
    else
      puts "all good"
      string << "yippy"
    end
  end
end

StringStuff.new.do_something "with this"
