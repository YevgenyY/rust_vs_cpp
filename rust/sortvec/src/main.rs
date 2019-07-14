extern crate rand;

use std::time::SystemTime;
use rand::Rng;

fn main() {
	let mut num: i32 = 0;
	let mut vec = vec![0, num];

	let now_alloc = SystemTime::now();
	for x in 0..100000000 {
		num = x; // dynamic allocation testing
		num = rand::thread_rng().gen();
		vec.push( num );
	}
	println!("Allocation time {:?}", now_alloc.elapsed());
	
	let now_sort = SystemTime::now();
	vec.sort();
	println!("Sorting time {:?}", now_sort.elapsed());
}
