defmodule Spelling do
  @behaviour Problem
  alias Types.Chromosome

  @target_word "ruth"

  @impl Problem
  def genotype_fn() do
    ln = String.length(@target_word)

    genes =
      Stream.repeatedly(fn -> Enum.random(?a..?z) end)
      |> Enum.take(ln)

    %Chromosome{size: ln, genes: genes}
  end

  @impl Problem
  def fitness_fn(chromosome) do
    target = @target_word
    candidate = List.to_string(chromosome.genes)

    String.jaro_distance(target, candidate)
  end

  @impl Problem
  def terminate?([best | _]) do
    IO.puts("Best Word: #{List.to_string(best.genes)}")
    best.fitness == 1
  end
end

solution = Genetic.run(Spelling)

IO.inspect(solution)
