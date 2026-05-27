# The AI of the Tiger
The goal of this project is to develop a static analyzer for the Tiger
language based on Abstract Interpretation.  Its objective is to
determine **statically** whether an array access is safe.  It must be
sound/correct/conservative (call it what you want), meaning that if it
classifies an array access as safe, it must be safe under all
circumstances (i.e. in all possible executions of the
program). Otherwise, the access should be considered unsafe.

# Language
This project is based on the [Tiger
language](https://assignments.lrde.epita.fr/reference_manual/tiger_language_reference_manual/semantics/semantics.html)
as you know with few differences: for pedagogical reasons, we restrict
ourselves to analyzing a subset of Tiger.  In particular, the version
we use does not handle:

- Function definitions (but function calls are allowed)
- Objects
- Records
- Nil

We further restrict ourselves to the following primitives:
- print
- print_int
- concat
- range*

Finally, to make the analysis more challenging, we have added a source of
non determinism inside the language in the form of the primitive:

````
/* range: int * int -> int */
range(low,sup)
```` 

Which samples randomly (and uniformly) an integer between `low` and
`sup` (inclusive)

# Where to start?
Try compiling the project. If you have dune and OCaml (> 5.0) installed, a
simple make should do the job.
If compilation is successful, launch the main executable on an example file.

- Usage `./src/concrete/tiger_concrete.exe tests/interpreter/interp00.tig`

This will by default parse the file, interpret it and exit the program.

If everything was successful, this should print 1.

It is also possible to print the constructed AST of the program using the `--show-ast` option as in the following example: 
- Usage `./src/concrete/tiger_concrete.exe tests/interpreter/interp00.tig --show-ast`

### Overview of this repository
- The `tests/` directory contains `.tig` files that you'll work with.
  * The subdirectory `good/` contain programs with **only valid array accesses**. Your goal is to make your analysis **precise** enough to recognize them as *valid as often as possible*.
  * The subdirectory `bad/` contain programs with **only invalid array access**. Your goal is to keep your analysis **sound**, ensuring that these access are *never accepted as valid*.
  * The subdirectory `interpreter/` contains simple Tiger programs not necessarily with array accesses. Their purpose is to let you observe how your analysis behaves on small, readable examples.
- The `src` directory contains the sources:
  * `ast/` contains everything source file related (ast, lexer, parser)
  * `interpreter/` contains everything related the interpreter
  * `analyzer/` contains everything related the static analyzer
  

# Your job
- You will go through the steps below to build both an interpreter and an analyzer for the tiger language.
- You will run the tests (`make test` to run the whole testsuite. Or use the more specific makefile targets for each step)
- If a "Not implemented yet" exception is raised, try to understand where it comes from and implement the missing feature

# Step 1 : Interpretation
The goal of this first part is to implement an *interpreter* for the
Tiger language.

Try the command :
`./src/concrete/tiger_concrete.exe --show-ast tests/interpreter/interp00.tig`

**Code to read:**
- `src/ast/ast.ml` : Describes the language through
the definition of its AST. Each element of the
language is represented as data types, enriched with location
information to allow accurate error tracking in the source
code. Expressions (expr) cover the usual constructs of the tiger
language: constants, variables, operations, control structures (if,
while, etc.), function calls, and initializations of arrays.
Lvalues ​(assignable values) allow assignment targets to be
modeled. Declarations (chunks) encapsulate the high-level blocks of a
program, whether they are type declarations, variables, or
expressions. Finally, a complete program is seen as a list of these
blocks.

- `src/interpreter/value.ml`: Defines the values ​​ handled at runtime
by the interpreter, grouped into a sum type that includes integers,
strings, arrays and void. It also provides dynamic conversion
functions (`cast_int`, `cast_array`) to check that a value is of the
expected type, with error reporting in case of failure.

**Code to write:**
- `src/interpreter/interpreter.ml`
This code implements a functional interpreter, with pure recursive
expression evaluation. The program state is modeled as an immutable
structure containing an environment of variables and a table of
functions. The implementation assumes well-typedness and more
generally, it is assumed that programs are well-formed.

Some hints:
  - Scopes are manually managed via a stack of environments (see `src/interpreter/env.ml`)
  - Assignable expressions (left-values) can be read or written
  - Native functions are integrated directly into the initial environment.
  - Since we suppose that programs are well typed, we don't need to deal with types i.e. type declarations have no effect

**Tests**
run `make interpretertest` This will look in the `tests/interpreter/`
directory, parse and evaluate each .tig Tiger file, compare the
evaluation result to a .print reference file and report whether the
interpreter output matches the expected result.

# Step 2 : Abstract Interpretation
The goal of this part is to implement an *abstract interpreter* for the
Tiger language.

You can run an analysis by running the new executable
`src/abstract/tiger_abstract.exe`.  You are first provided with the
constant abstract domain. It is not very precise, but it will allow
you to test your abstract interpreter. We will work on a more precise
domain at step 4.

For example, to run a constant analysis:
`./src/abstract/tiger_abstract.exe --show-ast tests/good/test00.tig`

You can use the `--annot` option to print the annotated ast: same as
`--show-ast` but annotated with abstract states.

`./src/abstract/tiger_abstract.exe --annot tests/interpreter/interp00.tig`

or the `--pdf` option to generate a pdf of the annotated ast (you'll need pdflatex installed)
``./src/abstract/tiger_abstract.exe tests/good/test00.tig --pdf`

**Code to read**
- `src/annotast/annotast.ml` defines an annotated version of the AST for the Tiger language.  It allows nodes of the
syntax tree to carry additional information (annotations) for static analysis.

- `src/analyzer/absvalue.ml` is an abstract version of the `value.ml`
module, designed for static analysis. It uses the same structure (Int,
String, Array, etc.), but uses abstract representations provided by a
parameterized module (Absint, Absstring, etc.). This allows for
handling value approximations rather than concrete values. It provides
the essential operations of an abstract domain (join, widen, subset)
and dynamic conversion functions (cast_*).

- `src/analyzer/absstate.ml` is an abstract version of the
`src/interpreter/state.ml` module.  In concrete states, runtime
environments map each variable to an exact value and each function to a
concrete implementation. In contrast, the abstract states model
possible sets of environments to enable static
analysis. Variable values are abstract, representing approximations
rather than exact values. Additionally, abstract states can represent
unreachable code paths using Bot (bottom element), which has no
equivalent in the concrete states. The abstract module also implements
operations like join, widen, and subset to handle merging and
comparison of states during analysis, which are absent in the concrete
version because they aren't needed during concrete execution.

**Code to write:**

- `src/analyzer/absinterpreter.ml` implements an abstract
interpreter. While `interpreter.ml` computes one possible execution of
the program, `absinterpreter.ml` computes an over-approximation of all
possible program execution.  A key difference is that
`absinterpreter.ml` is not only about evaluating expressions
abstractly. It is primarily used to build an annotated AST, where each
node is enriched with abstract information about the program state at
that point. Both interpreters are functional, recursive, and assume
well-typedness. However, absinterpreter.ml operates on abstract
domains, and explores all control-flow paths. Loops are handled
through fixpoint computation to account for all possible behaviors.

**Tests**
run `make consttest` This will look in the tests/
directory, parse and analyze each file using the constant abstract domain.

- For the files in tests/good/, the goal is to verify that all array
accesses are safe based on the interval information.  The program
keeps track of how many operations were correctly identified as safe,
and how many were not. This gives a precision score

- For the files in tests/bad/, as all array access are unsafe, the
analysis checks if some were incorrectly detected as safe.  If its the
case, it counts as a soundness error.

# Step 3 : Branching points
Initially, we suggest adopting a naive strategy for handling
**conditionals** and **loops** during the analysis.

**Conditional Statements (`if-then-else`)**

We will lift the logic used by the interpreter to the static world:

- If we can *statically prove* that the condition always evaluates to true, we analyze *only the then* branch.
- If we can *statically prove* that the condition always evaluates to false, we analyze *only the else* branch.
- If the condition is *uncertain* (i.e., we cannot decide statically), we conservatively analyze *both* branches and compute the *union* (*join*) of the resulting states.

**While Loops**

We apply a similar idea for `while` loops:
- We unroll the loop body by executing (analyzing) it body *as long as we cannot statically prove* that the condition is false.
- This unrolling continues up to a fixed maximum number of iterations (Utils.max_iter) to ensure termination.
- If the loop still cannot be proven to terminate within this bound, we raise a Max_unroll exception.
- To ensure that our analysis terminates, we limit the number of iterations to a fixed constant `Utils.max_iter`.
- In such cases, we fallback to a fixpoint-based analysis, which over-approximates the effect of possibly infinite loop executions.

This two-phase approach (bounded unrolling first, then fixpoint) allows us to:
- Capture simple loops precisely when they terminate quickly.
- Maintain soundness by switching to conservative approximation when necessary.

**Code to write:**
- `src/analyzer/absinterpreter.ml`. Complete the functions `analyze_if` and `unroll_while`

# Step 4 : Abstract Domains
The goal of this part is to equip our abstract interpreter with a more
accurate abstract domain: intervals.

You can run an interval analysis by doing for example:
`./src/abstract/tiger_abstract.exe --domain interval tests/good/test00.tig`

Running the tests:
`make intervaltest`

**Code to read**
- `src/domain/domain.ml` Defines the core abstract domain
interfaces used in the abstract interpreter. It provides modular and
extensible abstractions for handling integers, arrays, and strings in
a static analysis setting.

- `src/domain/constint.ml` Defines a simple abstract
domain for constant integers used by the abstract interpreter. Its
purpose is to represent and manipulate integer values abstractly,
either as known constants (Known i) or as unknown values (Top) that
stand for any integer.  This domain allows tracking precise values
when possible and falling back to Top when uncertainty
arises. Arithmetic operations like add, sub, mul, and div propagate
precision only if both operands are known; otherwise, they yield Top.
This abstraction supports truth evaluation and boolean logic as well,
though comparisons like eq, gt, etc., conservatively return Top (i.e.,
maybe true or false). Logical operations are similarly imprecise.

**Code to write**
- `src/domain/interval.ml` Defines an interval abstract domain for
static analysis. Each abstract value represents a range of possible
integers: either as a bounded `Range (low, high)`, or semi-infinite sets
like `Minf(up)` (all values ≤ up), `Inf(low)` (all values ≥ low), or the
completely unknown value `Top`.  It supports standard arithmetic
operations (add, sub, mul, div) which conservatively approximate
results by computing bounds over all possible outcomes. Comparisons
(gt, eq, etc.) return abstract booleans (true_, false_, or maybe_),
depending on whether the outcome is certain or not.

# Step 5 : Guards
The goal of this part is to equip our abstract domains with a precise
handling of boolean conditions in guard.

**Code to write**
- `src/analyzer/guard.ml` This module performs filtering over
annotated expressions, refining abstract states based on boolean
conditions and comparisons.

- `src/domain/interval.ml` modify the functions
used to refine intervals based on relational constraints (equality,
inequality, less than, greater than, etc.).

**Code to modify**
- `src/analyzer/absinterpreter.ml` You can now call
`Guard.filter` on the states that should be filtered.

# Step 6 : Fixpoint/Widening/Narrowing
The goal of this part is to equip our analyzer with a precise
convergence acceleration mechanism.

**Code to modify**
- src/domain/interval.ml: Implement the widening

- src/absinterpreter.ml: Use the widening in `analyze_while`:
Your function should compute a fixpoint to over-approximate the effect of
iterating the loop body zero or more times. It should :
  * Use widening to  ensure termination of the fixpoint iteration.
  * Refine the  abstract state at each iteration by filtering states where the
    condition holds.
  * After convergence, filter the final state by
    the negation of the loop condition to represent the state after
    exiting the loop.

# About Soundness
The interpreter and static analyzer provided to you are correct. By
that we mean that the result they give are trustable. Of course, they
only support a very small part of the language, and the analyzer
equipped with the abstract domain of constants is very imprecise. It
will therefore be up to you to increase the precision and the subset
of the supported language **while maintaining the correctness
property**. We prefer a correct analyzer with 30% accuracy, than an
incorrect analyzer with 90% accuracy.

**Make sure you have a sound analysis[!](https://ghilesz.github.io/ait_easter_egg.html)**