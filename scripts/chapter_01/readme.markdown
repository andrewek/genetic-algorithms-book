# Chapter 1

Going into this, my expectation was that we'd learn how to define algorithms
where the code itself mutates genetically, and I really didn't have any sense of
how that would or could work. Probably I've spent too much time with Ruby and
metaprogramming.

What seems to be the case, and we'll see if this bears out, is that we have
three parts:

1. Some data model representation of a domain object - these form the population
2. A way to evaluate that data representation against known criteria to produce
   a quantitative score.
3. An iterative process wherein we mix and match our data in exciting ways until
   we hit a maximum score.

Implicit here is that we're almost certainly working with domain experts to
define the data model and the criteria against we're evaluating the fitness of
any particular permutation.

That said, this section possibly confounds my understanding.

```elixir
algorithm =
  fn(population, algorithm) ->
    best = Enum.max_by(population, &Enum.sum/1)

    best_value = Enum.sum(best)
    IO.puts("Current best: #{best_value}")

    if best_value == 1000 do
      best
    else
      population
      |> evaluate.()
      |> selection.()
      |> crossover.()
      |> mutation.()
      |> algorithm.(algorithm)
    end
  end
```

We pass `algorithm` as an argument to itself. It's not totally clear to me
whether we do this because it's a function defined outside of a module (in this
case) and needs _some_ way of referencing itself, or if we expect `algorithm`
itself to chnage. In theory, `algorithm` could mutate or be re-defined each pass
through (like a closure or continuation). In practice, I have no idea how that
would work, and it seems like it would break the general spirit of doing this
functionally.

For the time being, my understanding is that `population` changes with each
iteration, but the algorithm stays the same, and the way we're working with it
right now is mostly a function of how we're calling the code in this particular
example, rather than a Sign of Things to Come.

I'll be curious to see if my understanding holds true.

The process the author outlines seems pretty straightforward:

1. Initialize Population
  + The early examples do this mostly with random or pseudo-random number
    generation. I'm curious whether there are other strategies we might use as
    well.
2. Evaluate Population
  + Get the score for each member of the population
3. Select Parents
  + Typically we'll sort by score, then combine the top two, the next two, and
    so on.
4. Generate children
  + For each pair of parents, generate 1 or more children - this seems to mostly
    be a matter of mixing and matching. For the one-max problem, we pick an
    arbitrary point in the string, slice, and swap. I'm curious how we'd work
    this if we were working with structs.
5. Mutate children
  + Introduce some randomness to avoid premature optimization

Then we're write back to Step 2 - Evaluating the population.

The chapter has us run the algorithm both with and without the "mutation"
stage. The overall speed was about the same (which makes sense if we're only
mutating 5% of the population, especially as the population sort of stratifies.

One thing I'd be curious about too would be seeing a histogram (or histogram-ish
chart) of scores across all populations per step. We know that on the top-end
they rise. Do they rise uniformly? Is there a bimodal distribution? Something
else? I could imagine small peaks forming and then eroding. I'm not sure how to
visualize that over time.

## Questions I have:

1. Is my understanding of genetic algorithms correct?
2. How far does the "genetics" metaphor go?
3. How do we model domain entities? How do we evaluate them numerically?
4. How do I tell if a problem is a good fit for a genetic algorithm?
