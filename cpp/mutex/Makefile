all: mutex_simple

mutex_simple: mutex_simple.cpp Makefile
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o mutex_simple -pthread mutex_simple.cpp

clean:
	rm mutex_simple
