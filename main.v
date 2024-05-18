module main

import os
import cli
import commands
// import server

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
			commands.pwgen
		]
	}
	app.setup()
	app.parse(os.args)
}
