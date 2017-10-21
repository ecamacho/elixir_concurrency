defmodule OctoberTalks.Futbol do
  
  def open_teams_file do
    case File.open("data/team.csv") do
      {:error, _} -> :no_existe
      {:ok, _} -> :existe
    end
  end

  def get_teams do
    File.stream!("data/team.csv")
    |> Stream.drop(1)
    |> Stream.map(fn(linea) -> String.split(linea, ",") end)            
    |> Enum.reduce(Map.new, fn(values, map) -> add_team_to_map(map, values) end)    
  end

  defp add_team_to_map(map, values) do
    Map.put(map, Enum.at(values, 1), String.replace(Enum.at(values, 3), "\"",""))
  end
end