%option noyywrap
%{
#include <stdio.h>
#include <map>
#include <string>
#include <iostream>

typedef std::map<std::string,int> histogram_t;
histogram_t counts;
int chars=0;
int lines=0;
%}
%%
[a-z]+          { counts[yytext] += 1; chars+=strlen(yytext); }

[\n]            { lines++; }
[ \t]           { }

.               { chars++; } // silently consume anything else
%%
int main()
{
    yylex();
    
    histogram_t::iterator it=counts.begin();
    while(it!=counts.end()){
        std::cout<<it->first<<" : "<<it->second<<"\n";
        ++it;
    }
    std::cout<<"\nTotal lines="<<lines<<"\n";
    std::cout<<"Total chars="<<chars<<"\n";
    return 0;
}
