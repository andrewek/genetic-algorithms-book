genotype_fn = fn -> for _ <- 1..1000, do: Enum.random(0..1) end

fitness_fn = fn(chromosome) -> Enum.sum(chromosome) end

max_fitness = 1000

solution = Genetic.run(fitness_fn, genotype_fn, max_fitness, [population_size: 100])

IO.inspect(solution)
