#!/usr/bin/env ruby


[11, 23, 33, 55, 62, 70, 80, 100, 101].bsearch { |e| puts e ; e >= 70 }
[11, 23, 33, 55, 62, 70, 80, 100, 101].bsearch { |e| puts e ; 100 <=> e }