module utils

import time

pub const timer = time.new_stopwatch()

pub fn elapsed() time.Duration {
	return utils.timer.elapsed()
}
