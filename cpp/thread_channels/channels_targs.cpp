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
//mutex g_mutex_vec;

typedef struct {
	vector<uint32_t> vec;
	thread thd;
	uint16_t id;
} Targ;


void threadFunc(Targ *targ)
{
	//lock_guard<mutex> guard(g_mutex_vec);
	targ->vec.reserve( NMAXMSG );
	for (int i=0; i < NMAXMSG; ++i)
	{
		targ->vec.push_back(targ->id + i);
	}
}

int main(int argc, char **argv) 
{
	Targ targs[ NTHREADS ];
	uint64_t acc = 0;

	auto start = chrono::steady_clock::now();
#if 1
	for (int i=0; i < NTHREADS; ++i) 
	{
		targs[ i ].id = i;
		targs[ i ].thd = thread( threadFunc, &(targs[i]) );
	}

#endif
	for (int i=0; i < NTHREADS; ++i)
		targs[i].thd.join();

	//g_vec.reserve( NTHREADS * NMAXMSG );
	for (int i=0; i < NTHREADS; ++i)
	{
		//move ( targs[i].vec.begin(), targs[i].vec.end(), std::back_inserter(g_vec) );
		//g_vec.insert( g_vec.end(), targs[i].vec.begin(), targs[i].vec.end() );
		/* the fastest */
		//for (int j=0; j < NMAXMSG; ++j)
		//	g_vec[i+j] = targs[i].vec[j];
		for (int j=0; j < NMAXMSG; ++j)
			acc += targs[i].vec[j];

		//cout << "#" << i << ": " << acc << endl;

	}

	auto end = chrono::steady_clock::now();

	cout << "Elapsed time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	cout << "Accumulator: " << acc << endl;
}
