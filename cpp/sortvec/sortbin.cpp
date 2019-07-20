#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>
#include <chrono>
#include <fstream>

using namespace std;

int main(int argc, char **argv) 
{
	int startTime, endTime, totalTime;
	vector<uint64_t> vec;
	uint64_t num;

	srand(time(NULL)); // randomize seed

	auto start = chrono::steady_clock::now();

	std::ifstream ifs;

	ifs.open("../../data/test.bin", std::ios::in | std::ios::binary);
	vector<char> buffer;
	buffer.assign(istreambuf_iterator<char>(ifs), istreambuf_iterator<char>());
	auto end = chrono::steady_clock::now();

	cout << "Elapsed file reading into vector in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	
	start = chrono::steady_clock::now();
	sort(buffer.begin(), buffer.end());
	end = chrono::steady_clock::now();

	totalTime = endTime - startTime;

	cout << "Elapsed sorting time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
}
