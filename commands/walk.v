module commands

import cli
import os
import utils
import sync.pool

const walk_path = cli.Flag{
	name: 'path'
	abbrev: 'p'
	flag: cli.FlagType.string
	description: 'specify path to walk recursively'
	default_value: [os.getwd() + '/']
}

// walk reads the initial directory and walks all subdirectories for parrallel processing
pub const walk = cli.Command{
	name: 'walk'
	description: 'walks a directory recursively (testing)'
	flags: [
		walk_path,
	]
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ${cmd.name} in ${utils.elapsed()}')
		// println(cmd.flags)
	}
	execute: fn (cmd cli.Command) ! {
		dir := cmd.flags.get_string('path')!
		all_files := utils.new_array()

		mut pp := pool.new_pool_processor(
			callback: fn [all_files] (mut pp pool.PoolProcessor, idx int, wid int) bool {
				item := pp.get_item[string](idx)
				os.walk(item, fn [all_files] (filename string) {
					all_files(filename)
				})
				return true
			}
		)
		mut dirs := []string{}
		paths := os.ls(dir) or { panic(err) }
		for path in paths {
			full_path := dir + path
			if os.is_dir(full_path) {
				dirs << full_path
			} else {
				all_files(full_path)
			}
		}
		println('walking ${dirs.len} directories...')
		pp.work_on_items(dirs)
		println('all_files: ${all_files('')}')
		println('all_files: ${all_files('').len}')
	}
}
