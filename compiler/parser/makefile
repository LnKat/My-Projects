.PHONY: clean distclean default

CXX=c++
CXXFLAGS=-Wall

default: pcl

lexer.cpp: lexer.l
	flex -s -o lexer.cpp lexer.l

lexer.o: lexer.cpp lexer.hpp parser.hpp

parser.hpp parser.cpp: parser.y
	bison  -dv -o parser.cpp parser.y

parser.o: parser.cpp lexer.hpp

pcl: lexer.o parser.o
	$(CXX) $(CXXFLAGS) -o pcl lexer.o parser.o

clean:
	$(RM) lexer.cpp parser.cpp parser.hpp parser.output *.o

distclean: clean
	$(RM) pcl

