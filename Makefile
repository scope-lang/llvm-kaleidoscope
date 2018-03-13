SOURCES = $(shell find ast kaleidoscope lexer logger parser -name '*.cpp')
HEADERS = $(shell find ast kaleidoscope lexer logger parser -name '*.h')
OBJ = $(SOURCES:.cpp=.o)

CC = g++
# -stdlib=libc++ -std=c++11

LLVMFLAGS =$(shell llvm-config --cxxflags --ldflags --system-libs --libs all)
CFLAGS = -g -O3 -I llvm/include -I llvm/build/include -I ./

.PHONY: main

main: main.cpp $(OBJ)
	$(CC) $(CFLAGS) $(LLVMFLAGS) -std=c++11 $(OBJ) $< -o $@

clean:
	rm -r $(OBJ)

%.o: %.cpp $(HEADERS)
	$(CC) $(CFLAGS) $(LLVMFLAGS) -c $< -o $@
