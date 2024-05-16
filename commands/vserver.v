module commands

import cli
import os
import veb

pub struct Context {
	veb.Context
}

pub struct App {
	veb.StaticHandler
	veb.Middleware[Context]
}


pub const v_server = cli.Command{
	name: 'server'
	description: 'Removes all node_modules from a cwd or specified paths'
	flags: [
		cli.Flag{
			name: 'path'
			abbrev: 'p'
			flag: cli.FlagType.string
			description: 'specify paths to search for static files'
			default_value: [os.getwd()]
		},
	]
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ' + cmd.name)
		// println(cmd.flags)
	}
	execute: fn (cmd cli.Command) ! {
		mut app := &App{}
		dir := cmd.flags.get_string('path')!
		app.handle_static(dir, true)!
		app.use(handler: fn(mut ctx Context) bool {
			println(ctx.req.method.str() + ' ' + ctx.req.url)
			return true
		})
		veb.run[App, Context](mut app, 8080)
		return
	}
}