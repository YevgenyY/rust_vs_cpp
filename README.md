# RUST vs C++: a subjective comparision based on different tests

## HARDARE / OS / compilers

1. CPU: Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz / 8 threads
2. RAM: Kingston DDR3, 32GB
3. OS: Linux host 4.4.0-148-generic #174-Ubuntu SMP Tue May 7 12:20:14 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
4. GCC: gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
5. RUST compiler: rustc 1.34.1 
6. CARGO: cargo 1.34.0

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
 0x0000000000000019 (INIT_ARRAY)         0x22cf08
 0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
 0x000000000000001a (FINI_ARRAY)         0x22cf10
 0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
 0x000000006ffffef5 (GNU_HASH)           0x2d0
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

*librt POSIX.1b Realtime Extensions library*
     Functions in this library provide  most  of  the  interfaces
     specified  by  the  POSIX.1b  Realtime Extension.  See stan-
     dards(5). Specifically, this includes the interfaces defined
     under   the   Asynchronous  I/O,  Message  Passing,  Process
     Scheduling, Realtime Signals Extension,  Semaphores,  Shared
     Memory  Objects,  Synchronized  I/O, and Timers options. The
     interfaces defined under the Memory  Mapped  Files,  Process
     Memory  Locking,  and  Range Memory Locking options are pro-
     vided in libc(3LIB)


Let's have a look at disassembled listing of hello\_world.rs executable.
```
objdump -d main | wc -l
31008
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

What size is disassembled listing of hello.cpp?

```
objdump -d hello | wc -l
244
```



