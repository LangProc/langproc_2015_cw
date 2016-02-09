

bin/c_lexer : src/c_lexer.yy.c
	g++ src/c_lexer.yy.c -o bin/c_lexer

src/c_lexer.yy.c : src/c_lexer.lex
	flex -o src/c_lexer.yy.c src/c_lexer.lex

clean :
	rm src/c_lexer.yy.c
	rm bin/c_lexer

