module commands

import cli
import os
import utils
// import sync.pool

const walk_path = cli.Flag{
	name: 'path'
	abbrev: 'p'
	flag: cli.FlagType.string
	description: 'specify path to walk recursively'
	default_value: [os.getwd() + '/']
}

// walk reads the initial directory and walks all subdirectories for parr
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
		files := utils.walker(dir)
		println('files: ${files.len}')
	}
}
