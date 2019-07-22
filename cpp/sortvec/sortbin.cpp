#include <iostream>
#include <vector>
#include <stdint.h>
#include <random>
#include <algorithm>
#include <chrono>
#include <fstream>
#include <arpa/inet.h>
#include <stdio.h>

using namespace std;

int main(int argc, char **argv) 
{
	int startTime, endTime, totalTime;
	vector<uint32_t> vec;
	uint32_t num;

	srand(time(NULL)); // randomize seed

	/* Read integers from file */
	auto start = chrono::steady_clock::now();

	streampos fileSize;
	ifstream ifs;
	ifs.open("../../data/test.bin", std::ios::binary);

	ifs.seekg(0, ifs.end);
	fileSize = ifs.tellg();
	ifs.seekg(0, ifs.beg);

	int numIntegers = fileSize / sizeof(uint32_t);
	uint32_t* buffer = new uint32_t [numIntegers];
	ifs.read(reinterpret_cast<char*>(buffer), fileSize);

	if (ifs)
		cout << "All chars read successfully" << endl;
#if 0
	while ( !ifs.eof() )
	{
		ifs.read(reinterpret_cast<char *>(&num), sizeof(num));
		vec.push_back( num );
		//cout << num << endl;
	}
#else
	for (int i=0; i < numIntegers; i++)
	{
		vec.push_back( buffer[i] );
		//cout << buffer[i] << endl;
	}
#endif

	auto end = chrono::steady_clock::now();
	/* end of reading */

	cout << "Elapsed file reading into vector in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	
	start = chrono::steady_clock::now();
	sort(vec.begin(), vec.end());
	end = chrono::steady_clock::now();

	totalTime = endTime - startTime;

	cout << "Elapsed sorting time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	cout << "Vector size is: " << vec.size() << endl;
}
