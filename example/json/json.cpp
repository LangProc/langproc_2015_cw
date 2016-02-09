#include "json_ast.hpp"

#include "json_parse.tab.hpp"

Value *g_ast; // Will be written by yyparse 

int main()
{
    yyparse();
    
    Value *ast=g_ast;
    
    ast->Print(std::cout);
    
    return 0;
}
