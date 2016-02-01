Create a code generator for arithmetic expressions
==================================================

Your program should accept C source code for a function
containing integer arithmetic on `stdin`, and generate
MIPS assembly for the function body on `stdout`.

Input Format
------------

The input format and constraints are the same as for the tokeniser, with
the following restrictions:

- the only data-type that will occur is `int`

- there are no control-flow statements

- there are no function calls

- all arithmetic is integer arithmetic

- there will be a single function with two integer arguments

Output Format
-------------

The output format is MIPS assembly, suitable for compilation with
GCC MIPS. The calling convention should be compatible with the
MIPS gcc toolchain.

Program build
-------------

From your top-level directory, doing:

    make bin/c_codegen

should create a programe called... `bin/c_codegen`.

Getting Started
---------------

If you want to see what the assembly for a function
should look like, then try running a mips compiler.
It will include lots of extra information, but the
core parts will be there.

