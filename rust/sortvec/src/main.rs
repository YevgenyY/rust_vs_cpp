extern crate rand;

use std::time::SystemTime;
use rand::{Rng, SeedableRng};

fn main() {
	let mut num: i64 = 0;
	let mut vec = vec![0, num];

	let now_alloc = SystemTime::now();
	for x in 0..1000000000 {
		//num = x; // dynamic allocation testing
		num = rand::random::<i64>();
		vec.push( num );
	}
	println!("Allocation time {:?}", now_alloc.elapsed());
	
	let now_sort = SystemTime::now();
	vec.sort();
	println!("Sorting time {:?}. Vector size is: {}", now_sort.elapsed(), vec.len());
}
