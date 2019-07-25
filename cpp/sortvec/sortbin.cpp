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
	vector<uint32_t> vec;
	uint32_t num;

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

	vec.resize(numIntegers); // this reduces exec time very well

	ifs.read(reinterpret_cast<char*>(buffer), fileSize);
	for (int i=0; i < numIntegers; i++)
	{
		vec[i] = buffer[i]; // the fastest
		//vec.push_back( buffer[i] );
		//cout << "Num: " <<  buffer[i] << endl;
	}

	auto end = chrono::steady_clock::now();

	cout << "numIntegers: " << numIntegers << endl;

	/* end of reading */

	if (ifs)
		cout << "Elapsed file reading into vector in milliseconds: " << 
			chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	else
		return -1;
	
	start = chrono::steady_clock::now();
	sort(vec.begin(), vec.end());
	end = chrono::steady_clock::now();

	cout << "Elapsed sorting time in milliseconds: " << 
		chrono::duration_cast<chrono::milliseconds>(end - start).count() << endl;
	cout << "Vector size is: " << vec.size() << endl;
}
