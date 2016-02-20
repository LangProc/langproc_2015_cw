CPPFLAGS += -W -Wall -g

json_parse.tab.cpp json_parse.tab.hpp : json_parse.y
	bison -d json_parse.y -o json_parse.tab.cpp

json_lex.yy.cpp : json_lex.lex json_parse.tab.hpp
	flex -o json_lex.yy.cpp  json_lex.lex


json : json.cpp json_lex.yy.cpp json_parse.tab.cpp json_parse.tab.hpp
	g++ $(CPPFLAGS) json.cpp  json_lex.yy.cpp json_parse.tab.cpp  -o json

all : json

