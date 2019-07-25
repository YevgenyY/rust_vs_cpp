use std::time::SystemTime;
use std::fs::File;
use std::io::Read;
use std::mem;

fn main() {
	let mut num: u32;
	let mut hugebuf: Vec<u8> = Vec::new();
	let mut vec: Vec<u32> = Vec::new();

	let now_alloc = SystemTime::now();
	let mut file = File::open("../../data/test.bin").expect("Error opening File");
	// read file as u8 vector
	file.read_to_end(&mut hugebuf);
	let mut buf = [0u8; 4];
	let mut i = 0;
	let mut j = 0;
	let vec_size = hugebuf.len() / 4;
	
	//vec.resize(vec_size, 0); // slightly reduces execution time 
	for x in hugebuf {
		buf[i] = x;
		i = i+1;
		if (i == 4) {
			num = unsafe { mem::transmute(buf) };
			//vec[j] = num; // slightly reduces exec time
			vec.push( num );
			i = 0;
			//println!("Num: {:?}", num);
			j += 1;
		}
	}

	println!("Allocation time {:?}", now_alloc.elapsed());
	println!("numIntegers {:?}", j);
	
	let now_sort = SystemTime::now();
	vec.sort();
	println!("Sorting time {:?}. Vector size is: {}", now_sort.elapsed(), vec.len());
}
