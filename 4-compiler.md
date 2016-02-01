Write a C Compiler
==================

Your compiler should accept C source code on `stdin`,
and generate MIPS assembly on `stdout`.

Input Format
------------

The input is C90.

Output Format
-------------

The output format is MIPS assembly, suitable for asssembling
and linking with the GCC MIPS toolchain.

Program build
-------------

From your top-level directory, doing:

    make bin/c_compiler

should create a programe called... `bin/c_compiler`.
