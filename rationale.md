Writing a working compiler is complex, difficult, and takes
a long time. There are multiple stages in the compiler, some
of which require custom tools. We recognise this, and so give
a lot of space to this coursework in terms of computer lab time
and time to do the coursework.

Observations on past experiences
--------------------------------

There are many things competing for your
time, including other courseworks. For some students
(and to be fair, academics), there is also a tendency to
leave things until a week before the deadline, just because.
This really doesn't work here, because a compiler is
more than just writing one piece of code - there are parser
tools to be understood and used, multiple stages to be
written, and the output needs to be tested. An observation
is that many students are still fighting with parser
tools a week before the deadline, when there were computing
labs weeks earlier which were dedicated to developing these
skills (to be fair, I think students do the exercises, but
don't connect them to how they will be used in practise).

A second problem is that because compilers consist of
multiple stages, a natural approach is to tackle stage
1, then stage 2, and so on. Given the constraints on
time, this often means that the delivered compiler contains
a perfectly working parser for the entire C grammar,
but no code generator. Or a code generator that produces
assembly that "looks right", but that does not actually
run. Even when the compiler works, this development
methodology means that any problems found in the last
stage might mean huge changes to earlier parts of the
pipeline. It is much better to have a complete end-to-end
compiler that works on a small subset of C, then
progressively add functionality to the entire compiler.

Arguments against an extremely structured coursework
---------------------------------------------------

One approach to both encourage better use of time,
and to encourage progressive refinement in development
practises, would be define highly structured and
very tightly specified assessed milestones. These could be
used to force everyone along the process every two weeks, making
sure that everyone
creates the right building blocks at some manageable
pace, and ensuring that those blocks will fit together
into a working compiler. A natural consequence would
be that the interfaces (function numes, data-types, etc.)
would have to be pre-defined, and everyone would use
the same internal structure for their compiler.

However, this has a number of
drawbacks, particularly as a learning experience:

- *It takes ownership of the compiler away from the
  student.* It would no longer be a compiler that you
  created, it would be a compiler that you built according
  to instructions from me. A bit like the difference
  between creating a chair from some bits of wood and
  some tools, versus assembling a chair from Ikea. It is
  a very powerful thing to be able to say "I created a
  fully working C compiler", so if someone says "what,
  you mean you followed a lab?", you want to be able to
  turn round and say "No, _I_ created a compiler".

- *You won't make as many mistakes.* It is important to
  do things wrong, in order to learn how to do things right.
  I could specify the building-blocks for a very well
  architected compiler, but you wouldn't be able to see
  _why_ it was well architected. This is also an exercise
  in designing and implementing software in general,
  and again, you might not realise why the data-structures
  look the way they do. Using the Ikea example again,
  their chairs are a model of economy - they use very
  few parts, yet are relatively easy to put together. What
  you don't see is the hundred prototypes they did and
  all the mistakes they made. It's much better if you
  build a wonky chair with six legs where only three
  touch the ground. Once you are proudly sitting on your
  fully functional chair, you can then look at it and
  thing "well it works, but maybe next time I won't use
  so many legs".
  
- *It implies there is a "right" way to do things.*
  Engineering is about trying to promote and standardise
  best practises, so we try to teach good ways of building
  things that maximise the chance of success. There are
  certain best-practises for designing compilers (and general
  software) that we teach, and hope you will follow. However,
  there is a huge amount of wiggle room within those
  guidelines that comes down to personal preference and/or
  intuition. If you look at GCC, CLANG, and MSVC, they all
  have radically different internal flows and data-structures,
  despite following the same classic approaches to structuring
  a compiler as multiple stages. Hopefully you look at and
  discuss your code with others, and what we/I would like
  is for you to encounter diversity of solutions. Your
  compiler design is unlikely to be optimal in all aspects,
  and it is good to see how others have done things so
  you can share experience and best practises.
  
- *It encourages... short-cuts.* Coming back to the time
  pressure problem, if there are highly structured incremental
  deliverables, then each unit of functionality must have
  well defined input and output APIs. This means the solution
  space is relatively small (as noted earlier), which means
  there is much more temptation to borrow from other people.
  This could be the more benign form, where someone looks
  at code to see how it is solved then writes their own
  version - not really a problem, but a missed learning
  opportunity. For a small minority, it might also lead to
  plagiarism, as highly structured deliverables make plagiarism
  easy to execute, and lulls students into thinking that it won't
  be detected (as "they'll all look the same anyway").
  
- *What happens if milestones are missed?* If each
   assessed module builds on the previous module,
   what happens if a student is unable to complete one
   of the modules - are they then unable to complete the
   rest of the coursework? Similarly, if a module is
   only partially working, it could mean the next module
   is also limited in the same way. One approach would
   be to give out reference implementations, but that
   comes straight back to suggesting there is a "right"
   way that each milestone should have been completed.
  
Argments for low structured intermediate milestones
---------------------------------------------------

The approach for this year is to attempt to strike a
balance between the previous single deadline approach,
and the alternate highly structured approach. There
are now intermediate deliverables, which are designed
according to the following principles:

- *Loosely specified.* Only inputs and outputs are defined,
  so internal implementation is completely up to the
  student.

- *A funnel of functionality.* The milestones reflect
  stages within a compiler, but at each stage request
  _less_ functionality. This is to encourage a focus
  on getting a compiler that goes all the way through
  to code-gen _before_ adding all the bells and whistles.

- *Low weighted.* While assessed, the milestones are
  not the main focus - they are simply there to ensure
  they are taken seriously in order to encourage success
  for the final deliverable.

- *Not direct building blocks.* While the intermediate
  deliverables are parts of a compiler, they do not
  directly result in a compiler. With good planning, the
  same functionality can be used from within the
  final compiler. Alternatively, the code from
  the milestones can be modified and re-used within the
  final compiler.

- *Force the use of tools.* There are certain tools
  that need to be used in developing and testing a
  compiler, and the milestones ensure some real experience
  with them, well before the final deadline.


