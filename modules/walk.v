module main

import os
import time

pub fn new_array() fn (s string) []string {
	mut i := []string{}
	return fn [mut i] (s string) []string {
		if s == '' {
			return i
		}
		i << s
		return i
	}
}

const arrr = new_array()

pub fn isdir(s string) bool {
	isd := os.is_dir(s)
	if isd {
		return true
	} else {
		return false
	}
}

fn spawner(ar fn (string) []string, p string) {
	println('walking directory: ${p}')
	os.walk(p, fn [ar] (filename string) {
		ar(filename)
	})
}

fn main() {
	timer := time.new_stopwatch()
	spawner(arrr, os.getwd())
	
	println(arrr(''))
	println(arrr('').len)
	println('elapsed: ${timer.elapsed()}')
}
