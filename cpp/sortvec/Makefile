all: sortvec sortbin

sortvec: sortvec.cpp Makefile
	g++ -std=c++11 -Ofast -o sortvec -fomit-frame-pointer sortvec.cpp

sortbin: sortbin.cpp Makefile
	g++ -std=c++11 -Ofast -o sortbin -fomit-frame-pointer sortbin.cpp
clean:
	rm sortvec
	rm sortbin
