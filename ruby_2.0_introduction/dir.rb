#!/usr/bin/env ruby

puts __dir__

puts __FILE__

puts File.dirname(File.realpath(__FILE__)) == __dir__