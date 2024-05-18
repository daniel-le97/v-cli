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
		}
		post_execute: fn (cmd cli.Command) ! {
		}
		commands: [
			commands.v_server,
			commands.node,
			commands.search,
			commands.editor,
		]
	}
	app.setup()
	app.parse(os.args)
}
