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

I tried it with an initial population of 1000, and it seemed to plateau for a
much longer time (with the one-max problem). I couldn't tell if this is because
each iteration step just took longer, or if it was stalled for more steps.

Trying with a very small population converged very quickly on a poor solution.

## Questions I Have

We still have the genetic metaphor. Where does it break down?

Right now the crossover and mutate functions are closely tied to the one-max
problem (and more generally to lists as the data structure for a chromosome).
I'm curious whether that crossover changes if our chromosomes are structs (for
example), and if so, how?

There seem to be additional opportunities to make our Elixir code better.
Notably, something like parallel map for evaluation.

I'm curious whether there are cases where we'll want to reason about the entire
population at each step, rather than just checking to see if something has
bubbled to the top?

What happens if nothing converges to maximum fitness?
