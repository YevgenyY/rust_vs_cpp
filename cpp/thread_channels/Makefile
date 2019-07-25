all: channels_mutex channels_nonlock channels_targs

channels_mutex: channels_mutex.cpp
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o channels_mutex -pthread channels_mutex.cpp

channels_nonlock: channels_nonlock.cpp
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o channels_nonlock -pthread channels_nonlock.cpp

channels_targs: channels_targs.cpp
	g++ -std=c++11 -Ofast -fomit-frame-pointer -o channels_targs -pthread channels_targs.cpp
clean:
	rm channels_mutex
	rm channels_nonlock
	rm channels_targs
