module commands

import cli
import os
import time
import utils
// import arrays

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

const sw = time.new_stopwatch()
const search_path = cli.Flag{
	name: 'path'
	abbrev: 'p'
	flag: cli.FlagType.string_array
	description: 'specify paths to search through'
	default_value: [os.getwd()]
}

pub const search = cli.Command{
	name: 'search'
	description: 'searches for strings in specified paths'
	flags: [
		search_path,
	]
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ${cmd.name} in ${utils.elapsed()}')
	}
	execute: fn (cmd cli.Command) ! {
		dir := cmd.flags.get_strings('path')!
		for path in dir {
			os.walk(path, fn [cmd] (filename string) {
				for arg in cmd.args {
					if filename.contains(arg) {
						println(filename)
					}
				}
			})
		}

		return
	}
}
