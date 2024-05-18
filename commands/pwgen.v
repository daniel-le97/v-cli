

module commands

import cli
import rand
import clipboard

// Define the characters to use in the password
const letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
	'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
const numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
const special_chars = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '[',
	']', '{', '}', '|', ';', ':', ',', '<', '>', '.', '?', '/', '`', '~']

struct Opts {
mut:
	length   int
	specials bool
	password string
}

const password_len = 32 // Set the desired length of the password

const length_flag = cli.Flag{
	name: 'length'
	abbrev: 'l'
	flag: cli.FlagType.int
	description: 'specify the length of the password'
	default_value: [password_len.str()]
}
const specials_flag = cli.Flag{
	name: 'specials'
	abbrev: 's'
	flag: cli.FlagType.bool
	description: 'use special characters?'
	default_value: ['true']
}

pub const pwgen = cli.Command{
	name: 'pwgen'
	description: 'generate a random password'
	flags: [length_flag, specials_flag]
	post_execute: fn (cmd cli.Command) ! {
		println('Executed: ' + cmd.name)
		// println(cmd.flags)
	}
	execute: fn (cmd cli.Command) ! {
		mut usable_characters := []string{}
		mut pw_characters := []string{}

		for letter in letters {
			usable_characters << letter
			usable_characters << letter.to_upper()
		}
		for number in numbers {
			usable_characters << number
		}

		leng := cmd.flags.get_int('length')!
		spec := cmd.flags.get_bool('specials')!
		if spec {
			for special in special_chars {
				usable_characters << special
			}
		}

		for i := 0; i < leng; i++ {
			pw_characters << rand.element(usable_characters)!
		}
		mut c := clipboard.new()
		password := pw_characters.join('')
		println('Generated password: ')
		println(password)
		c.copy(password)

		println('Password copied to clipboard.')
		// clipboard.new()
		return
	}
}
