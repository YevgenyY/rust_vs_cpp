extern crate rand;

use std::time::SystemTime;
use rand::{Rng, SeedableRng};

fn main() {
	let MAXNUM = 100 * 1000 * 1000;
	let mut num: i32 = 0;
	let mut vec = Vec::new();

	let now_alloc = SystemTime::now();
	for x in 0..MAXNUM {
		//num = x; // dynamic allocation testing
		num = rand::random::<i32>();
		vec.push( num );
	}
	println!("Allocation time {:?}", now_alloc.elapsed());
	
	let now_sort = SystemTime::now();
	vec.sort();
	println!("Sorting time {:?}. Vector size is: {}", now_sort.elapsed(), vec.len());
}
