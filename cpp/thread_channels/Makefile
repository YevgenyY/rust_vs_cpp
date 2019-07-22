all: channels_mutex channels_nonlock

channels_mutex: channels_mutex.cpp
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o channels_mutex -pthread channels_mutex.cpp

channels_nonlock: channels_nonlock.cpp
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o channels_nonlock -pthread channels_nonlock.cpp
clean:
	rm channels_mutex
	rm channels_nonlock
