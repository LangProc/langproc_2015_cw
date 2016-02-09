Create a tokeniser for the C language.
======================================

Your program should accept C source code on
`stdin` and write the tokens out to `stdout`,
one token per line.

Input format
------------

The input file will be pre-processed [ANSI C](https://en.wikipedia.org/wiki/ANSI_C),
also called C90 or C89. It's what's generally thought of as "classic" or "normal" C,
but not the _really_ old one without function prototypes (you may never have come
across that). C90 is still often used in embedded systems, and pretty much the
entire linux kernel is in C90.

We've mainly taught you C++, but you're probably aware of C as a subset of C++ without
classes, which is a good mental model. I will also explicitly state that your
programs (lexer, parser and compiler) will never be given code that has different
parsing or execution semantics under C and C++ (so for example I won't give you code that
uses "class" as an identifier).

The source code will not contain any compiler-specific or platform-specific
extensions. If you pre-process a typical program (see later), you'll see many
things such as `__attribute__` or `__declspec` coming from the system headers. You will
not need to deal with any of these[^1].

The test inputs will be a set of files of increasing complexity and
variety. The initial files will contain a small number of basic tokens,
then the lexicon will be increased, and finally Pre-Processor directives
(see next section) will included. All files will be well-formed.

Output Format
-------------

Each line should have the form:

  TokenText TokenClass TokenType LineNum SourceFile SourceLine

where the parts are:

- TokenText : The original text of the token, not including any
  surrounding white-space.

- TokenClass : Describes the class of token, with one of the following classes:

  - "Keyword" : `while`, `if`, ...

  - "Identifier" : `x`, `y`, `x6`, ...

  - "Operator" : `(`, `[`, `+`

  - "Constant" : `42`, `1.0`, ...

  - "StringLiteral" : `"Hello from the other side"`, `"(other side)"`, ...

  - "Invalid" : An unknown token type.

  The surrounding speech marks should not appear in the output.

  *Note*: This does not make any distinction between "operators" and
  "punctuators" which you will see in some C grammars. We will ignore
  the distinction and only have an operators class.

- TokenType : Assigns a unique string to each token type, identifying
    which specific token it is. You can choose any unique string
    to identify each token (e.g. a number or identifier), as long as they
    do not contain whitespace.

- LineNum : The line number the token appears on, in terms of the source
  stream. The first line number is 1.

- SourceFile : The source file the token came from. See Pre-Processor section
  for details on file-names - if you do not support file-names, then do not
  include this token.

- SourceLine : The source line the token came from. See comment

It is legal (but not as good) if you omit parts later in
the line (e.g. SourceFile), but it is not legal to skip a part
(e.g. to include LineNum but omit TokenType).

Program build
-------------

From your top-level directory, doing:

    make bin/c_lexer

should create a programe called... `bin/c_lexer`. The
makefile from the spec will do this by default.

You are free to use C or C++ (or something else if it
is installed in the environment), and may make use
of other tools such as bison or yacc as part of your build process.


Pre-Processor
-------------

TLDR : if you don't want to support pre-processor information, then
if you encounter a `#` character that is _not_ in a string literal,
consume all characters to the end of the line.

If needed, the input will already have been pre-processed, which means
that all instances `#define` and `#include` will already have been processed. However,
you may still see some input lines from the pre-processor. Create a simple
file called `tmp.c`:

    echo -e "#include <stdio.h>\nint main(){\n  printf(\"Wibble\"); \n}\n" > tmp.c
    less tmp.c

We can now pre-process it with `cpp`, the [GNU C Pre-Processor](https://gcc.gnu.org/onlinedocs/cpp/):

    cpp tmp.c

You should should see a load of stuff from the standard includes, then
your tiny program at the bottom. You can get a better look with `less`:

    cpp tmp.c | less

At the top of the file you'll see something like `# 1 tmp.c`, then
references to various files like `/usr/include/stdio.h` and `/usr/include/sys/config.h`.
If you scroll down, eventually you'll see the first non-empty line that
_doesn't_ start with `#` - in my case it is `typedef signed char __int8_t;`,
but it could be something else. This represents the first true token,
and will be the first line that should cause a token to be output.

The format of the `#` lines is explained in the [Pre-Processor Manual](https://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html),
though you can get a good sense of what is going on by comparing
the original headers and the output of `cpp`. `less` has a mode
the displays line numbers (the `-N` option), so do:

    cpp tmp.c | less -N

in one terminal, and in another terminal do:

    less -N /usr/include/stdio.h

It gives quite a good insight into how the transformation
happens, as you can match up the lines in the original
versus the lines in the `#` output, and see where comments
and `#define`s have been removed.

Note: there is no requirement that the input has been pre-processed,
so there may be no `#` lines at all. Use the default filename
"<stdin>" as the SourceFile if there is no information provided
by a pre-processor.

Footnotes
=========

[^1] - Some thought indicates _why_ you won't see extensions. Things
       like `__attribute__` are a side-channel between the implementer
       of the C run-time and the compiler, or the OS interface and the
       compiler. It is necessary that both sides agree on what those
       extensions mean, so for example the writers of `libc` have to talk
       to the writers of `gcc` about what they need and why. The C
       standard recognises that this is necessary, and so explicitly reserves
       identifiers beginning with two under-scores as "implementation defined",
       where "implementation" means the compiler.

       So in this instance _you_ are the implementation. Given you have
       not defined any extensions, logically there are no possible extensions
       that could occur.
