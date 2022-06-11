# Chapter 03 - Encoding Problems and Solutions

## Genetic Metaphor

+ **chromosome**: a full solution candidate
+ **gene**: a single data point within a chromosome
+ **allele**: a value encapsulated by the gene

In this chapter we introduce `Types.Chromosome` which is a data structure
representing a full solution candidate. In addition to `genes` we also have
`size`, `fitness`, and `age`.

Doing it this way means we can persist older candidates across generations (or
cull them as new solutions take their place). We can also do so without having
to recalculate fitness.

Additionally, we introduce the `Problem` behaviour, which gives us a ready-built
structure for encapsulating an entire problem.

**Genotypes** are the representation of a solution as genes.

**Phenotypes** are the actual world-model solution.

In the one-max problem, the phenotype is a bitstring, and the genotype is the
list of 0's and 1's.

In a shortest-route problem, the genotype is a list of stops in order, whereas
the phenotype is the actual graph of nodes.

### Types of Genotypes

The most common type of genotype is the bitstring (an array of 0's and 1's),
which is sometimes called a *binary genotype*.

In some cases this might be an encoded value. In other cases it might be like a
bit-mask where each digit represents the presence (or absence) of a trait.

Crossover solutions are relatively trivial with binary genotypes.

The second most common is a *permutation* genotype, which is a list of unique values in
some order. You use this for optimization of paths or other types of ordered
solutions. Crossover solutions are much more challenging because the solution
might not even be valid.

The third most common type is the *real value* genotype, where you've got a list of
actual values (strings or floats or whatever), which you might use if you were
looking to represent something where you need precision or are generating words
(for example).

Finally, there is a *tree* genotype, which the book does not discuss in much
detail. These apparently get used to model ASTs, which are neat, and would be
used to write software that writes software if that were an effective strategy.
This is called "genetic programming" and doesn't seem to be particularly useful
or effective (at least per the author).

Again, the main problem seems to be finding a good way to model the problem.

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

The author hints at a number of optimization strategies yet to come.

## Questions I Have

I'm still a bit lost on how we model problems.

I still don't understand yet how we figure out when we have a good enough
solution if we're asking a problem that doesn't necessarily have a single
correct solution.
