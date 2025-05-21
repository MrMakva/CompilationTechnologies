#!/bin/sh

CXXFLAGS="-Wall -I. -Wno-unused -Wno-deprecated -Wno-write-strings -Wno-free-nonheap-object -std=c++20"
LDFLAGS=""

echo "Generating parser and lexer..."
bison -d -v -y -b cool --debug -p cool_yy -o cool-bison-parser.cc cool.bison
flex -d -o cool-flex-lexer.cc cool.flex

echo "Compiling source files..."
g++ $CXXFLAGS -c parser-phase.cc
g++ $CXXFLAGS -c utilities.cc -o utilities.o
g++ $CXXFLAGS -c stringtab.cc
g++ $CXXFLAGS -c cool-tree.cc
g++ $CXXFLAGS -c inheritance_graph.cc
g++ $CXXFLAGS -c cool-flex-lexer.cc
g++ $CXXFLAGS -c cool-bison-parser.cc

echo "Linking..."
g++ $LDFLAGS $CXXFLAGS \
    parser-phase.o \
    utilities.o \
    stringtab.o \
    cool-tree.o \
    inheritance_graph.o \
    cool-flex-lexer.o \
    cool-bison-parser.o \
    -o parser