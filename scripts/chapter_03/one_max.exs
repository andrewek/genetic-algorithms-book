defmodule OneMax do
  @behaviour Problem
  alias Types.Chromosome

  @size 42

  @impl Problem
  def genotype_fn() do
    genes = for _ <- 1..@size do
      Enum.random(0..1)
    end

    %Chromosome{genes: genes}
  end

  @impl Problem
  def fitness_fn(chromosome) do
    Enum.sum(chromosome.genes)
  end

  @impl Problem
  def terminate?([best | _]) do
    best.fitness == @size
  end
end

solution = Genetic.run(OneMax)

IO.inspect(solution)
