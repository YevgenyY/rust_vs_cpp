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


	for (int i=0; i < 100000000; ++i) 
	{
		num = rand();
		vec.push_back(num);
		//cout << num << endl;
	}

	startTime = time(NULL);
	sort(vec.begin(), vec.end());
	endTime = time(NULL);

	totalTime = endTime - startTime;

	std::cout << "Runtime: " << totalTime << " seconds." << endl;
}
