#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>
#include <chrono>

using namespace std;

int main(int argc, char **argv) 
{
	int startTime, endTime, totalTime;
	vector<uint32_t> vec;
	uint32_t num;

	srand(time(NULL)); // randomize seed

	auto start = chrono::steady_clock::now();
	for (int i=0; i < 100000000; ++i) 
	{
		//num = i; // dynamic allocation test only
		//num = ((long long)rand() << 32) | rand();
		num = rand();
		vec.push_back(num);
	}
	auto end = chrono::steady_clock::now();

	cout << "Elapsed allocation time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	
	start = chrono::steady_clock::now();
	sort(vec.begin(), vec.end());
	end = chrono::steady_clock::now();

	totalTime = endTime - startTime;

	cout << "Elapsed sorting time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	cout << "Vector size: " << vec.size() << endl;
}
