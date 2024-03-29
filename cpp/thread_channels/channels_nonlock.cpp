#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>
#include <thread>
#include <mutex>
#include <chrono>

#define NTHREADS 256
#define NMAXMSG 1000000

using namespace std;

vector<uint32_t> g_vec(NTHREADS * NMAXMSG);

void threadFunc(int tid)
{
	for (int i=0; i < NMAXMSG; ++i)
	{
		g_vec[tid + i] = tid + i;
	}
}

int main(int argc, char **argv) 
{
	thread tarr[ NTHREADS ];
	uint64_t acc = 0;

	auto start = chrono::steady_clock::now();

	for (int i=0; i < NTHREADS; ++i) 
	{
		tarr[ i ] = thread( threadFunc, i );
	}

	for (int i=0; i < NTHREADS; ++i)
		tarr[i].join();
	
#if 1
	for (int i=0; i < NTHREADS; ++i)
	{
		for (int j = 0; j < NMAXMSG; ++j)
		{
			acc += g_vec[i + j];
		}
		//cout << "#" << i << ": " << acc << endl;
	}

#endif

	auto end = chrono::steady_clock::now();

	cout << "Elapsed time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;

	cout << "Accumulator: " << acc << endl;
}
