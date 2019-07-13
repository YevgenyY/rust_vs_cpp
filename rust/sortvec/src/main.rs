extern crate rand;

use std::time::SystemTime;
use rand::Rng;

fn main() {
	let mut num: i32 = 0;
	let mut vec = vec![0, num];

	for x in 0..100000000 {
		num = rand::thread_rng().gen();
		vec.push( num );
	}
	
	let now = SystemTime::now();
	vec.sort();
	println!("{:?}", now.elapsed());
}
