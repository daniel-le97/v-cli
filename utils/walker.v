module utils

import sync.pool
import os

pub fn walker(p string) []string {
	// db_path := os.home_dir()
	// db_exist := os.exists()
	arr := new_array()
	mut pp := pool.new_pool_processor(
		callback: fn [arr] (mut pp pool.PoolProcessor, idx int, wid int) bool {
			item := pp.get_item[string](idx)
			os.walk(item, fn [arr] (filename string) {
				arr(filename)
			})
			return true
		}
	)
	paths := os.ls(p) or { panic(err) }
	mut dirs := []string{}
	for path in paths {
		full_path := p + path
		if os.is_dir(full_path) {
			dirs << full_path
		} else {
			arr(full_path)
		}
	}
	pp.work_on_items(dirs)
	return arr('')
}
