defmodule Genetic do
  @moduledoc """
  Basic framework for the Genetic Algorithm
  """

  alias Types.Chromosome

  @doc """
  Entrypoint
  """
  def run(problem, opts \\ []) do
    population = initialize(&problem.genotype_fn/0, opts)

    population
    |> evolve(problem, opts)
  end

  @doc """
  Combine parents to make new children
  """
  def crossover(population, _opts) do
    Enum.reduce(population, [], fn({parent_1, parent_2}, acc) ->
      split_point = :rand.uniform(length(parent_1.genes))

      {{h1, t1}, {h2, t2}} = {Enum.split(parent_1.genes, split_point), Enum.split(parent_2.genes, split_point)}

      child_1_genes = h1 ++ t2
      child_2_genes = h2 ++ t1

      child_1 = %Chromosome{parent_1 | genes: child_1_genes}
      child_2 = %Chromosome{parent_2 | genes: child_2_genes}

      [child_1, child_2 | acc]
    end)
  end

  @doc """
  Given a list of chromosomes, evaluate each against the fitness function and
  then sort by that fitness
  """
  def evaluate(population, fitness_fn, opts) do
    population
    |> Enum.map(fn(chromosome) ->
      fitness = fitness_fn.(chromosome)
      age = chromosome.age + 1
      %Chromosome{chromosome | fitness: fitness, age: age}
    end)
    |> Enum.sort_by(& &1.fitness, &>=/2)
  end

  @doc """
  Do the steps!
  """
  def evolve(population, problem, opts) do
    population = evaluate(population, &problem.fitness_fn/1, opts)

    best = hd(population)

    IO.puts("Current best: #{best.fitness}")

    if problem.terminate?(population) do
      best
    else
      population
      |> select(opts)
      |> crossover(opts)
      |> mutation(opts)
      |> evolve(problem, opts)
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
        %Chromosome{chromosome | genes: Enum.shuffle(chromosome.genes)}
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
