Create a parser for the C language
==================================

Your program should accept C source code on
`stdin` and write a heirarchical representation on stdout.

Input Format
------------

The input format and constraints are the same as for the tokeniser, with
the following restrictions: 

- the only data-type that will occur is `int` (so no arrays, structs, floats, void)

- the only control-flow statements are `if`, `while` and `for`

- all functions are definitions (i.e. there are no declarations)

These restrictions do _not_ apply to the eventual compiler, they are
simply to make this stage more manageable as a milestone. You are
encouraged to support these things as well, but the intent here is
to get a core set of functionality fully working.

The input format is still C90, and it is worth noting
a difference between the C90 ("classic) and C99 ("modern")
languages, which is that declarations can only appear
at the top of a scope. So all variables declarations will
appear before any statements. See the later section for more discussion

Output Format
-------------

The output format will be a heirarchical format, which identifies
the functions, scopes, and variables.

For each function declaration the program should print:

    FUNCTION : function_name
    
then for each parameter it should print (with an indent of four spaces):

        PARAMETER : parameter_name

At the start of each scope the program should print:

    SCOPE

and increase the indentation by four spaces.

For each declared variable in a scope the program should print:

    VARIABLE : variable_name

As a simple example, the following function:

    int f( int x)
    {
        int y=x;
        return y;
    }
    
should result in:

    FUNCTION : f
        PARAMETER : x
    SCOPE
        VARIABLE : y

This code:

    int x()
    {}
    
    int g;
    
    int zz(int a, int b, int c)
    {
      if(a==b)
        return z
      else{
        int fsdfsdfs;
        return c;
      }
    }
    
would result in:

    FUNCTION : x
    SCOPE
    VARIABLE : g
    FUNCTION : zz
        PARAMETER : a
        PARAMETER : b
        PARAMETER : c
    SCOPE
        SCOPE
            VARIABLE : fsdfsdfs

Program build
-------------

From your top-level directory, doing:

    make bin/c_parser

should create a programe called... `bin/c_parser`.



C90 Declarations
----------------

In C99 (like C++) you are allowed to interleave declarations and statements:

    int f(int i)
    {
        int x=i+5;
        x=x*x;
        int y=x+4;
        return y;
    }
    
In C90, you must have all declarations before any statements,
so that would need to be re-written as:

    int f(int i)
    {
        int x=i+5;
        int y;
        x=x*x;
        y=x+4;
        return y;
    }

Note that declarations can happen at the start of any scope, so things like:

    int f(int i)
    {
        int x=i+5;
        x=x*x;
        if(1){
            int y=x+4;
            return y;
        }
    }

Thinking about it with your knowledge of parsers and compilers,
you might be able to guess why the older language is more restricted,
while the newer one relaxes it. You also might guess why I
deliberately chose the older syntax for you to implement.

It's worth noting that beyond compiler implementation, there
are many arguments for and against both styles. An argument
for requiring C90 style declarations is that you have
immediate visibility of the total number of variables in a scope.
This gives you a sense of the complexity of a function,
as you can see how many moving parts there are. For example,
Linus Torvalds [likes that aspect](https://lkml.org/lkml/2012/4/12/18),
as the kernel is an extremely large and complex code-base.
There are also rules in the [MISRA-C](https://en.wikipedia.org/wiki/MISRA_C)
guidelines for automotive and embedded software that state
that variables should appear at function scope.

One argument for the newer style is convenience, but also
the idea that that it is better to declare a variable at
the point that it is initialised. A common error in C is
to have a variable which is not initialised on all code
paths:

    {
       int i;
       
       // Much code
       
       if(getc()){
           i=1;
       }
       
       // So codey
       
       putc(i+1);
    }

Modern compilers will put out a warning about `i` potentially
being used before being initialised, but people may just
ignore that. The move towards more functional and declarative
styles has also encouraged this process - for example, the
`auto` keyword in C++11.
