module commands

import cli
import os
import utils
// import json
// import sync.pool

// const redis_path = cli.Flag{
// 	name: 'path'
// 	abbrev: 'p'
// 	flag: cli.FlagType.string
// 	description: 'specify path to walk recursively'
// 	default_value: [os.getwd() + '/']
// }

// walk reads the initial directory and walks all subdirectories for parr
pub const redis = cli.Command{
	name: 'redis'
	description: 'redis in a cli'
	// flags: [
	// 	walk_path,
	// ]
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ${cmd.name} in ${utils.elapsed()}')
		// println(cmd.flags)
	}
	execute: fn (cmd cli.Command) ! {
		homedir := os.home_dir()
		println('Home: ${homedir}')
		// dir := cmd.flags.get_string('path')!
		// files := utils.walker(dir)
		// println('Files: ${files.len}')
		// jsoner := json.encode_pretty(files)
		// os.write_file('walk.json', jsoner) or { panic(err) }
	}
}
