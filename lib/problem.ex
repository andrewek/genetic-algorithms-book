defmodule Problem do
  @moduledoc """
  We encapsulate a single problem.

  genotype/0 creates new a single new chromosome
  fitness_function/1 returns a numeric score for a single chromosome
  terminate?/1 determines whether we can stop the process
  """

  alias Types.Chromosome

  @callback genotype_fn :: Chromosome.t

  @callback fitness_fn(Chromosome.t) :: number()

  @callback terminate?(Enum.t) :: boolean()
end
