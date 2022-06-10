# Chapter 1 - OneMax

# Given a bytestring (0's and 1's) of length _n_, what is the maximum sum of all
# elements in a string.
#
# Intuitively, the answer is _n_ (a string of all 1's), but we're going to do it
# genetically.

# Generate 100 lists, each with 1000 elements
population = for _ <- 1..100 do
  for _ <- 1..1000 do
    Enum.random(0..1)
  end
end

# Assign a numeric score to each element, then sort by that score
evaluate = fn(population) ->
  Enum.sort_by(population, &Enum.sum/1, &>=/2)
end

# Group into parents
selection = fn(population) ->
  population
  |> Enum.chunk_every(2)
  |> Enum.map(&List.to_tuple(&1))
end

# Generate children
crossover = fn(population) ->
  Enum.reduce(population, [], fn {p1, p2}, acc ->
    cx_point = :rand.uniform(1000)

    {{h1, t1}, {h2, t2}} =
      {Enum.split(p1, cx_point), Enum.split(p2, cx_point)}

    [h1 ++ t2, h2 ++ t1 | acc]
  end)
end

mutation = fn(population) ->
  Enum.map(population, fn(chromosome) ->
    if :rand.uniform() < 0.05 do
      Enum.shuffle(chromosome)
    else
      chromosome
    end
  end)
end

algorithm = fn(population, algorithm) ->
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

solution = algorithm.(population, algorithm)

IO.puts("The Answer Is:")
IO.inspect(solution)
