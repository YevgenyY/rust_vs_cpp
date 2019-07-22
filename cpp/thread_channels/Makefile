all: channels_mutex

channels_mutex: channels_mutex.cpp
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o channels_mutex -pthread channels_mutex.cpp

clean:
	rm channels_mutex
