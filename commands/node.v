module commands

import cli
import os
import arrays

pub fn new_counter() fn () int {
	mut i := 0
	return fn [mut i] () int {
		i++
		return i
	}
}

const node_path = cli.Flag{
	name: 'path'
	abbrev: 'p'
	flag: cli.FlagType.string
	description: 'specify paths to search for node_modules'
	default_value: [os.getwd()]
}

pub const node = cli.Command{
	name: 'node'
	description: 'Removes all node_modules from a cwd or specified paths'
	flags: [
		node_path,
	]
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ' + cmd.name)
		// println(cmd.flags)
	}
	execute: fn (cmd cli.Command) ! {
		dir := cmd.flags.get_string('path')!
		mut files_arr := []string{}
		mut files_ref := &files_arr
		c := new_counter()
		println('Checking ${dir} for node_modules')
		os.walk(dir, fn [mut files_ref, c] (filename string) {
			c()
			if filename.contains('Library') {
				return
			}
			if filename.contains('node_modules') {
				realname := filename.before('node_modules') + 'node_modules'
				files_ref << realname
			}
		})

		println('checked ${c() - 1} paths')
		files := arrays.distinct(files_arr)
		if files.len == 0 {
			println('No node_modules found')
			return
		}
		for file in files {
			if os.is_dir(file) {
				println('removing: ' + file)
				os.rmdir_all(file) or { println('Failed to remove: ' + file) }
			}
		}
		return
	}
}
