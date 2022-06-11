defmodule Genetic do
  @moduledoc """
  Basic framework for the Genetic Algorithm
  """

  @doc """
  Entrypoint
  """
  def run(fitness_fn, genotype_fn, max_fitness, opts \\ []) do
    population = initialize(genotype_fn, opts)

    population
    |> evolve(fitness_fn, genotype_fn, max_fitness, opts)
  end

  @doc """
  Combine parents to make new children
  """
  def crossover(population, opts) do
    Enum.reduce(population, [], fn({parent_1, parent_2}, acc) ->
      split_point = :rand.uniform(length(parent_1))

      {{h1, t1}, {h2, t2}} = {Enum.split(parent_1, split_point), Enum.split(parent_2, split_point)}

      child_1 = h1 ++ t2
      child_2 = h2 ++ t1

      [child_1, child_2 | acc]
    end)
  end

  @doc """
  Given a list of chromosomes, evaluate each against the fitness function and
  then sort by that fitness
  """
  def evaluate(population, fitness_fn, opts) do
    population
    |> Enum.sort_by(fitness_fn, &>=/2)
  end

  @doc """
  Do the steps!
  """
  def evolve(population, fitness_fn, genotype_fn, max_fitness, opts) do
    population = evaluate(population, fitness_fn, opts)

    best = hd(population)

    IO.puts("Current best: #{fitness_fn.(best)}")

    if fitness_fn.(best) == max_fitness do
      best
    else
      population
      |> select(opts)
      |> crossover(opts)
      |> mutation(opts)
      |> evolve(fitness_fn, genotype_fn, max_fitness, opts)
    end
  end

  @doc """
  Create the initial population
  """
  def initialize(genotype, opts) do
    size = Keyword.get(opts, :population_size, 100)

    for _ <- 1..size, do: genotype.()
  end

  @doc """
  5% chance of mutating a given child
  """
  def mutation(population, opts) do
    Enum.map(population, fn(chromosome) ->
      if :rand.uniform() < 0.05 do
        Enum.shuffle(chromosome)
      else
        chromosome
      end
    end)
  end

  @doc """
  Transform sorted list of parents into pairings
  """
  def select(population, opts) do
    population
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple(&1))
  end
end
