module commands

import cli
import os
import arrays
import utils

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
		println('Executed: ${cmd.name} in ${utils.elapsed()}')
		// println(cmd.flags)
	}
	execute: fn (cmd cli.Command) ! {
		dir := cmd.flags.get_string('path')!

		c := utils.new_counter()
		push := utils.new_array()
		restricted := ['Library', '.app', '/.']
		println(restricted)
		println('Checking ${dir} for node_modules')
		os.walk(dir, fn [c, restricted, push] (filename string) {
			c()
			for rest in restricted {
				if filename.contains(rest) {
					println('restricted ${filename}')
					return
				}
			}
			if filename.contains('node_modules') {
				realname := filename.before('node_modules') + 'node_modules'
				push(realname)
			}
		})

		println('checked ${c() - 1} paths')
		files := arrays.distinct(push(''))
		if files.len == 0 {
			println('No node_modules found')
			return
		}
		println('found ${files.len} folders to delete')
		for file in files {
			if os.is_dir(file) {
				println('removing: ' + file)
				os.rmdir_all(file) or { println('Failed to remove: ' + file) }
			}
		}
		return
	}
}
