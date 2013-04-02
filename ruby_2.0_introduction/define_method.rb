#!/usr/bin/env ruby

module MyModule
  def pick_me
    "thanks"
  end
end

define_method :pick_me, MyModule.instance_method(:pick_me)

puts pick_me