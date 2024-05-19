module commands

import cli
import utils
import time



const timer = time.new_stopwatch()

pub const main_app = cli.Command{
	name: 'cli'
	description: 'cli for common task utils for my system'
	execute: fn (cmd cli.Command) ! {
		// if a command is not passed in, execute the help command
		cmd.execute_help()
	}
	pre_execute: fn (cmd cli.Command) ! {
	}
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ${utils.elapsed()}')
	}
	commands: [
		v_server,
		node,
		search,
		editor,
		pwgen,
	]
}
