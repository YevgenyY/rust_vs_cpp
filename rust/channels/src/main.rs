use std::time::SystemTime;
use std::sync::mpsc::{Sender, Receiver};
use std::sync::mpsc;
use std::thread;

static NTHREADS: i32 = 256;
static NMAXMSG: i32 = 1000000;
static NELEM: i32 = NTHREADS * NMAXMSG;

fn main() {
    // Channels have two endpoints: the `Sender<T>` and the `Receiver<T>`,
    // where `T` is the type of the message to be transferred
    // (type annotation is superfluous)
    //let (tx, rx): (Sender<i32>, Receiver<i32>) = mpsc::channel();
    let (tx, rx) = mpsc::channel();

    let mut children = Vec::new();

    let now = SystemTime::now();
    for id in 0..NTHREADS {
        // The sender endpoint can be copied
        let thread_tx = tx.clone();

        // Each thread will send its id via the channel
        let child = thread::spawn(move || {
            // The thread takes ownership over `thread_tx`
            // Each thread queues a message in the channel
            let mut tmp_vec = Vec::with_capacity(NMAXMSG as usize);
            for j in 0..NMAXMSG {
                tmp_vec.push(id +j);
            }
            thread_tx.send(tmp_vec).unwrap();

            // Sending is a non-blocking operation, the thread will continue
            // immediately after sending its message
            // println!("thread {} finished", id);
        });

        children.push(child);
    }

    // Here, all the messages are collected
    let mut rvec = Vec::with_capacity(NMAXMSG as usize);
    let mut result = Vec::with_capacity(NELEM as usize);
    for _ in 0..NTHREADS {
        // The `recv` method picks a message from the channel
        // recv` will block the current thread if there are no messages available
        rvec = rx.recv().unwrap();
        for elem in rvec {
            //println!("received: {}", elem);
            result.push(elem);
        }
    }
    
    // Wait for the threads to complete any remaining work
    for child in children {
        child.join().expect("oops! the child thread panicked");
    }

    println!("{:?}", now.elapsed());
    println!("Vector size: {}", result.len());

}
