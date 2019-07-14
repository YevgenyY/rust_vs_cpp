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

//vector<pair<uint32_t, vector<uint32_t>>> vec(NTHREADS);
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
