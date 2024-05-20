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

pub fn isdir(s string) bool {
	isd := os.is_dir(s)
	if isd {
		return true
	} else {
		return false
	}
}

fn spawner(p string) []string {
	arr := new_array()
	println('walking directory: ${p}')
	os.walk(p, fn [arr] (filename string) {
		arr(filename)
	})
	return arr('')
}

fn main() {
	timer := time.new_stopwatch()
	cwd_paths := os.ls(os.getwd()) or { panic(err) }
	mut threads := []thread []string{}
	// nice := []thread![]string{}
	for path in cwd_paths {
		if isdir(path) {
			threads << spawn spawner(path)
			// sthr := spawn spawner(path)
		}
	}

	r := threads.wait()
	// me := spawn os.ls('')
	for stuff in r {
		println('all jobs finished ${stuff}')
	}
	// println(arr(''))
	// println(arr('').len)
	println('elapsed: ${timer.elapsed()}')
}
