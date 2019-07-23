use std::time::SystemTime;
use std::sync::{Mutex, Arc};
use std::thread;

static NTHREADS: i32 = 1024;
static NCOUNT: u64 = 10000000;

fn main() {
    let counter = Arc::new(Mutex::new(0_u64));
    let mut handles = vec![];

    let now = SystemTime::now();
    for _ in 0..NTHREADS {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();

            for _ in 1..NCOUNT {
                *num += 1 + *num;
            }
        });
        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }

    println!("Result: {}", *counter.lock().unwrap());
    println!("{:?}", now.elapsed());

}

