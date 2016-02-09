%code requires{
  #include <stdio.h>
  
  #include "json_ast.hpp"
  
  extern Value *g_ast; // A way of getting the AST out
  
  //! This is to fix problems when generating C++
  int yylex(void);
  void yyerror(const char *);
}

%union{
  Value *value;
  Object *object;
  Array *array;
  double number;
  const char *string;
}

%token COLON COMMA LSQUARE RSQUARE LCURLY RCURLY STRING NUMBER

%type <value> OBJECT ARRAY VALUE ROOT
%type <object> STRING_VALUE_LIST
%type <array> VALUE_LIST 
%type <string> STRING
%type <number> NUMBER

%start ROOT

%{
struct pair_t *root=0;
%}

%%

OBJECT : LCURLY STRING_VALUE_LIST RCURLY { $$=$2; }
       | LCURLY RCURLY { $$=new Object(); } 
       

STRING_VALUE_LIST : STRING_VALUE_LIST COMMA STRING COLON VALUE { $1->Add($3,$5); $$=$1; }
                | STRING COLON VALUE  { $$=new Object(); $$->Add($1,$3); }

ARRAY : LSQUARE VALUE_LIST RSQUARE { $$=$2; }
      | LSQUARE RSQUARE { $$=new Array(); }
      
VALUE_LIST : VALUE_LIST COMMA VALUE { $1->Add($3); $$=$1; }
           | VALUE { $$=new Array(); $$->Add($1); }
           
VALUE : STRING { $$=new String($1); }
      | NUMBER { $$=new Number($1); }
      | OBJECT { $$=$1; }
      | ARRAY  { $$=$1; }

ROOT : ARRAY { g_ast = $1; }
     | OBJECT { g_ast = $1; }

%%
