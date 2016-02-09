%option noyywrap

%{
#include "json_parse.tab.hpp"
%}

%%
":"             { return COLON; }
","             { return COMMA; }
"["             { return LSQUARE; }
"]"             { return RSQUARE; }
"{"             { return LCURLY; }
"}"             { return RCURLY; }
[0-9]+          { yylval.number=atoi(yytext); return NUMBER; }
["][^"]*["]      { yylval.string=strdup(yytext); return STRING; }
%%

void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
  exit(1);
}
