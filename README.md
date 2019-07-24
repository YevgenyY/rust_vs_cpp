# RUST vs C++: Subjective comparison based on different tests

## SUMMARY


|  Test name                              | RUST (rustc 1.34.1)             | C++ (gcc 5.4.0) | C++ (clang 3.8.0)         |
| --------------------------------------- |:-------------------------------:| ---------------:|--------------------------:|
| HelloWorld executable dynamic libs      | libdl,librt,pthread,libgcc,libc |libstdc++, libc  | libstdc++,libm,libgcc,libc|
| HelloWorld executable disassembled size | 31008 lines                     |  244 lines      | 254 lines                 |
| 100M vector of integers mem allocation  | 0.168 seconds                   |  0.341 second   | 0.340 seconds             |
| 100M vector of random integers sorting  | 6.74 seconds                    |  6.8 seconds    | 6.70 seconds              |
| Sorting a file of 1Gb random integers /dev/urandom| 18.8 seconds                    |  18.5 seconds   | 17.9 seconds              |
| Channels, 256 senders, 1M messages each | 0.600 seconds                   |  0.794 seconds  |                           |
| Mutex benchmark (1024 threads)          | 0.865 seconds                   |  7.121 seconds  | 0.622 seconds             |


## HARDARE / OS / compilers

1. CPU: Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz / 8 threads
2. RAM: Kingston DDR3, 32GB
3. OS: Linux host 4.4.0-148-generic #174-Ubuntu SMP Tue May 7 12:20:14 UTC 2019 x86\_64 x86\_64 x86\_64 GNU/Linux
4. GCC: gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
5. Clang: clang version 3.8.0-2ubuntu4 (tags/RELEASE\_380/final), Apr 2017
6. RUST compiler: rustc 1.34.1 
7. CARGO: cargo 1.34.0

## RUST

### Hello world

```rust
fn main() {
    println!("Hello, world!");
}
```

The size of executable is:  263280 bytes. In case we use *--opt-level=s or z* compiler's options the size reduces slightly.

Have a look at dynamic section of executable.
```
readelf -d main

Dynamic section at offset 0x2e880 contains 29 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
 0x0000000000000001 (NEEDED)             Shared library: [librt.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [libgcc_s.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [ld-linux-x86-64.so.2]
 0x000000000000000c (INIT)               0x6048
 0x000000000000000d (FINI)               0x226a4
 0x0000000000000019 (INIT\_ARRAY)         0x22cf08
 0x000000000000001b (INIT\_ARRAYSZ)       8 (bytes)
 0x000000000000001a (FINI\_ARRAY)         0x22cf10
 0x000000000000001c (FINI\_ARRAYSZ)       8 (bytes)
 0x000000006ffffef5 (GNU\_HASH)           0x2d0
 0x0000000000000005 (STRTAB)             0x1578
 0x0000000000000006 (SYMTAB)             0x588
 0x000000000000000a (STRSZ)              7071 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000000000015 (DEBUG)              0x0
 0x0000000000000003 (PLTGOT)             0x22ea90
 0x0000000000000007 (RELA)               0x3390
 0x0000000000000008 (RELASZ)             11448 (bytes)
 0x0000000000000009 (RELAENT)            24 (bytes)
 0x0000000000000018 (BIND\_NOW)           
 0x000000006ffffffb (FLAGS\_1)            Flags: NOW PIE
 0x000000006ffffffe (VERNEED)            0x3270
 0x000000006fffffff (VERNEEDNUM)         5
 0x000000006ffffff0 (VERSYM)             0x3118
 0x000000006ffffff9 (RELACOUNT)          397
 0x0000000000000000 (NULL)               0x0
```
As we can see there are *librt, libdl, libpthread, libc, libgcc* libraries.

*librt - POSIX.1b Realtime Extensions library*

     Functions in this library provide  most  of  the  interfaces
     specified  by  the  POSIX.1b  Realtime Extension.  See stan-
     dards(5). Specifically, this includes the interfaces defined
     under   the   Asynchronous  I/O,  Message  Passing,  Process
     Scheduling, Realtime Signals Extension,  Semaphores,  Shared
     Memory  Objects,  Synchronized  I/O, and Timers options. The
     interfaces defined under the Memory  Mapped  Files,  Process
     Memory  Locking,  and  Range Memory Locking options are pro-
     vided in libc(3LIB)

*libdl - dynamic linking library*

     Historically, functions in libdl provided for dynamic linking support.
     This functionality now resides in libc(3LIB).

     This library is maintained to provide backward compatibility for both
     runtime and compilation environments. The shared object is implemented as
     a filter on the runtime linker. See ld.so.1(1). New application
     development need not specify -ldl.

*libpthread - POSIX threads library*

     Historically, functions in this library provided POSIX threading support.
     See standards(5). This functionality now resides in libc(3LIB).

     This library is maintained to provide backward compatibility for both
     runtime and compilation environments. The shared object is implemented as
     a filter on libc.so.1. New application development need not specify
     -lpthread although doing so has no effect.

*libc - overview of standard c libraries on linux*

     the  term  "libc"  is  commonly used as a shorthand for the "standard c 
     library", a library of standard functions that can be used by all c programs 
     (and sometimes by programs in other languages).  because of some history (see 
     below), use of the term "libc" to refer to the standard c library is somewhat 
     ambiguous on linux.

*libgcc - GCC's runtime library*
   
     The library contains some low-level functions that GCC emits calls to (like 
     long long division on 32-bit CPUs).


Let's have a look at [disassembled listing](https://raw.githubusercontent.com/YevgenyY/rust_vs_cpp/master/rust/simple_hello/main.asm) of hello\_world.rs executable.
```
objdump -d main | wc -l
31008
```

### RUST 100M integers vector sorting 

Sorting algorithm has a computational complexity estimation of O(n log n).

```rust
extern crate rand;

use std::time::SystemTime;
use rand::Rng;

fn main() {
        let mut num: i32 = 0;
        let mut vec = vec![0, num];

        let now_alloc = SystemTime::now();
        for x in 0..100000000 {
                // num = x; // only dynamic allocation testing
                num = rand::thread_rng().gen();
                vec.push( num );
        }
        println!("Allocation time {:?}", now_alloc.elapsed());

        let now_sort = SystemTime::now();
        vec.sort();
        println!("Sorting time {:?}. Vector size is {}", now_sort.elapsed(), vec.len());
}
```


### RUST channels: Receiver, Senders

Let's take the example of channel demonstration from the RUST book.
To make it more complicated we will create 256 threads. Each thread 
generates 1M vector of integers and sends it to receiver. Receiver 
collects all the vectors/messages from threads.

```rust
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
```


## C++

### Hello world
```c++
#include <iostream>

using namespace std;

int main(int argc, char **argv)  {
        cout << "Hello world" << endl;
}
```

What differences are there in the dynamic section of the executable?

```
Dynamic section at offset 0xe18 contains 25 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [libstdc++.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x000000000000000c (INIT)               0x4006a0
 0x000000000000000d (FINI)               0x400944
 0x0000000000000019 (INIT_ARRAY)         0x600df8
 0x000000000000001b (INIT_ARRAYSZ)       16 (bytes)
 0x000000000000001a (FINI_ARRAY)         0x600e08
 0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
 0x000000006ffffef5 (GNU_HASH)           0x400298
 0x0000000000000005 (STRTAB)             0x400400
 0x0000000000000006 (SYMTAB)             0x4002c8
 0x000000000000000a (STRSZ)              360 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000000000015 (DEBUG)              0x0
 0x0000000000000003 (PLTGOT)             0x601000
 0x0000000000000002 (PLTRELSZ)           168 (bytes)
 0x0000000000000014 (PLTREL)             RELA
 0x0000000000000017 (JMPREL)             0x4005f8
 0x0000000000000007 (RELA)               0x4005c8
 0x0000000000000008 (RELASZ)             48 (bytes)
 0x0000000000000009 (RELAENT)            24 (bytes)
 0x000000006ffffffe (VERNEED)            0x400588
 0x000000006fffffff (VERNEEDNUM)         2
 0x000000006ffffff0 (VERSYM)             0x400568
 0x0000000000000000 (NULL)               0x0
```

There are only two shared libraries: *libstdc++ and libc*.

*libstdc++ - is an implementation of the C++ standard library, 
targeting C++11, C++14 and above*

    Features and Goals
        Correctness as defined by the C++11 standard.
        Fast execution.
        Minimal memory use.
        Fast compile times.
        ABI compatibility with gcc’s libstdc++ for some low-level features 
            such as exception objects, rtti and memory allocation.
        Extensive unit tests.
    Design and Implementation:
        Extensive unit tests
        Internal linker model can be dumped/read to textual format
        Additional linking features can be plugged in as “passes”
        OS specific and CPU specific code factored out


What size is the [disassembled listing](https://github.com/YevgenyY/rust_vs_cpp/blob/master/cpp/hello/hello.asm) of hello.cpp?

```
objdump -d hello | wc -l
244
```

### C++ 100M integers vector sorting

Sorting algorithm has a computational complexity estimation of O(n log n).

```c++
#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>

using namespace std;

int main(int argc, char **argv) 
{
        int startTime, endTime, totalTime;
        vector<uint32_t> vec;
        uint32_t num;

	srand(time(NULL)); // randomize seed

        for (int i=0; i < 100000000; ++i) 
        {
		//num = i; dynamic allocation test only
                num = rand();
                vec.push_back(num);
        }

        startTime = time(NULL);
        sort(vec.begin(), vec.end());
        endTime = time(NULL);

        totalTime = endTime - startTime;

        std::cout << "Runtime: " << totalTime << " seconds." << endl;
}
```

The dynamic allocation time is 1 second.

Sorting time of 100M random vector of uint32\_t integers is 35 sec. 

### C++ channel emulation using std::thread: Receiver, Senders

Let's do the same task using C++ std::thread. We will create 256 threads
each of them generates 1M vector of uint32\_t integers and sends it to the
receiver. Receiver collects all the messages in a vector.

In this task we are using a mutex approach for locking threads. Of course 
there are some more interesting non-locking ones.

```c++
#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>
#include <thread>
#include <mutex>

#define NTHREADS 256
#define NMAXMSG 1000000

using namespace std;

vector<uint32_t> g_vec;
mutex g_mutex_vec;

void threadFunc(int tid)
{
        lock_guard<mutex> guard(g_mutex_vec);
        for (int i=0; i < NMAXMSG; ++i)
        {
                g_vec.push_back(tid + i);
        }
}

int main(int argc, char **argv) 
{
        thread tarr[ NTHREADS ];

        int startTime, endTime, totalTime;

        startTime = time(NULL);

        for (int i=0; i < NTHREADS; ++i) 
        {
                tarr[ i ] = thread( threadFunc, i );
        }

        for (int i=0; i < NTHREADS; ++i)
                tarr[i].join();

        endTime = time(NULL);
        totalTime = endTime - startTime;

        std::cout << "Runtime: " << totalTime << " seconds. vector size: "  << g_vec.size() << endl;
}

```

