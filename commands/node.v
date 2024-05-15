module commands
import cli
import os
import arrays
pub const node := cli.Command{
				name: 'node'
				description: 'Removes all node_modules from a cwd or specified paths'
				flags: [
					cli.Flag{
						name: 'path'
						abbrev: 'p'
						flag: cli.FlagType.string_array
						description: 'specify paths to search for node_modules'
						default_value: [os.getwd()]
					},
				]
				post_execute: fn (cmd cli.Command) ! {
					println('Executed: ' + cmd.name)
					// println(cmd.flags)
				}
				execute: fn (cmd cli.Command) ! {
					dir := cmd.flags.get_strings('path')!
					mut files_arr := []string{}
					mut files_ref := &files_arr
					for path in dir {
						println('Searching in: ' + path)
						os.walk(path, fn [mut files_ref] (filename string) {
							if filename.contains('node_modules') {
								realname := filename.before('node_modules') + 'node_modules'
								files_ref << realname
							}
						})
					}
					files := arrays.distinct(files_arr)
					if files.len == 0 {
						println('No node_modules found')
						return
					}
					for file in files {
						println('removing: ' + file)
						os.rmdir_all(file) or { println('Failed to remove: ' + file) }
					}
					return
				}
			}
