module main

import os
import commands

// import server

fn main() {
	mut app := commands.main_app
	app.setup()
	app.parse(os.args)
}
