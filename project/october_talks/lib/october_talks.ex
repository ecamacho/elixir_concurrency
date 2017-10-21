defmodule OctoberTalks do
  @moduledoc """
  Documentation for OctoberTalks.
  """

  @doc """
  Hello world.

  ## Examples

      iex> OctoberTalks.hello
      :world

  """
  def hello do
    :world
  end

  def es_par?(n) do
    par? n
  end

  defp par?(n) when rem(n, 2) == 0 do
    true
  end

  defp par?(_) do
    false
  end

  def solo_pares_ordenados(lista) do
    lista
    |> Enum.filter( fn(n) -> es_par?(n) end)
    |> Enum.sort
  end
end
