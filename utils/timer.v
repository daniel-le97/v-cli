module utils

import time

// this is a global stopwatch, does not require enabling globals
pub const timer = time.new_stopwatch()

pub fn elapsed() time.Duration {
	return timer.elapsed()
}
