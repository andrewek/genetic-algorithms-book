# Chapter 02 - Breaking Down Genetic Algorithms

The first broad thesis of this chapter is that there exists a general framework
for genetic algorithms:

1. Initialize the population
2. Evaluate the population
3. Select Parents
4. Generate children
5. Mutate children

These steps will always be performed in this order.

This means we can inject dependencies for the following:

+ A function that generates the initial population (more specifically, a
  function that generates a single member of the initial population).
+ A function for evaluating fitness of a given chromosome
+ A function for generating children (given 2 parents)
+ A function for mutating a given child

## The Genetics Metaphor

### Chromosomes

Each element of a population is a "chromosome". Each chromosome is a bit of data
representing one possible solution.

### Population Size

Larger populations might converge on a solution faster. Smaller populations are
quicker to work with (as each pass through simply takes less time).

The author's contention here is that pretty much any population size can work,
and that 100 is a fine starting number.

## Suitability of Elixir

The author contends that Elixir is an ideal language for this type of work,
mostly because we're already in the habit of writing functions that take some
data and return some data (rather than writing objects that do stuff to
themselves). In that sense, I suspect any functional language would be well
suited, though Elixir certainly has very pleasant ergonomics.

The author does not touch on this in Chapter 1 that I recall, but I'd suspect
that the ability to do things like `pmap` (and otherwise leverage concurrency
and the BEAM) also make it uniquely suited to this type of work relative to a
single-threaded language. Similarly, Elixir's ability to call other processes
(e.g. with NIFs), utilities, executables, etc. seems like it'll come into play,
though I'd bet that's outside the scope of what the book offers.

## Questions I Have
