#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>
#include <thread>
#include <mutex>
#include <chrono>

#define NTHREADS 1024
#define NMAXMSG 10000000

using namespace std;

mutex mtx_num;
static uint64_t num = 0;

void threadFunc(int tid)
{
	lock_guard<mutex> guard(mtx_num);
	for (int i=0; i < NMAXMSG; ++i)
	{
		num += 1 + num;
	}
}

int main(int argc, char **argv) 
{
	thread tarr[ NTHREADS ];

	auto start = chrono::steady_clock::now();

	for (int i=0; i < NTHREADS; ++i) 
	{
		tarr[ i ] = thread( threadFunc, i );
	}

	for (int i=0; i < NTHREADS; ++i)
		tarr[i].join();

	auto end = chrono::steady_clock::now();

	cout << "Elapsed time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	cout << "Result: " << num << endl;
}
