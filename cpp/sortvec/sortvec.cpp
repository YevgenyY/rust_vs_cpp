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
		//num = i; // dynamic allocation test only
		num = rand();
		vec.push_back(num);
	}

	startTime = time(NULL);
	sort(vec.begin(), vec.end());
	endTime = time(NULL);

	totalTime = endTime - startTime;

	std::cout << "Runtime: " << totalTime << " seconds." << endl;
}
