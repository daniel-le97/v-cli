module utils

pub fn new_counter() fn () int {
	mut i := 0
	return fn [mut i] () int {
		i++
		return i
	}
}

pub fn new_array() fn (s string) []string {
	mut i := []string{}
	return fn [mut i] (s string) []string {
		if s == '' {
			return i
		}
		i << s
		return i
	}
}
