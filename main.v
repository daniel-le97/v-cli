module main

import os
import cli
import commands

fn main() {
	mut app := cli.Command{
		name: 'cli'
		description: 'cli for common task utils for my system'
		execute: fn (cmd cli.Command) ! {
			// if a command is not passed in, execute the help command
			cmd.execute_help()
		}
		pre_execute: fn (cmd cli.Command) ! {
			// something you want to run before the main command is executed
		}
		post_execute: fn (cmd cli.Command) ! {
			// something you want to run after the main command is executed
		}
		commands: [
			commands.v_server,
			commands.node,
			commands.search,
		]
	}
	app.setup()
	app.parse(os.args)
}
