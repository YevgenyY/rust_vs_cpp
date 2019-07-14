# RUST vs C++: a subjective comparision based on differnet tests

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
 0x0000000000000001 (NEEDED)             *Shared library: [libpthread.so.0]*
 0x0000000000000001 (NEEDED)             *Shared library: [libgcc_s.so.1]*
 0x0000000000000001 (NEEDED)             *Shared library: [libc.so.6]*
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
 0x0000000000000018 (BIND_NOW)           
 0x000000006ffffffb (FLAGS_1)            Flags: NOW PIE
 0x000000006ffffffe (VERNEED)            0x3270
 0x000000006fffffff (VERNEEDNUM)         5
 0x000000006ffffff0 (VERSYM)             0x3118
 0x000000006ffffff9 (RELACOUNT)          397
 0x0000000000000000 (NULL)               0x0
```


## C++

### Hello world
