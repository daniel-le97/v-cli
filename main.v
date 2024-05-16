module main

import os
import cli
import commands

fn main() {
	mut app := cli.Command{
		name: 'cli'
		description: 'cli for common task utils for my system'
		execute: fn (cmd cli.Command) ! {
			cmd.execute_help()
		}
		commands: [
			commands.v_server
			commands.node
		]
	}
	app.setup()
	app.parse(os.args)
}
