defmodule OctoberTalks.FutbolFlow do

  def start do
    get_teams()
    |> get_goals_per_team
  end

  def get_teams do
    File.stream!("data/team.csv")
    |> Stream.drop(1)
    |> Flow.from_enumerable
    |> Flow.map(&String.split(&1, ","))
    |> Flow.partition
    |> Enum.reduce(Map.new, fn(values, map) -> add_team_to_map(map, values) end)    
  end

  defp add_team_to_map(map, values) do
    Map.put(map, Enum.at(values, 1), String.replace(Enum.at(values, 3), "\"",""))
  end


  def get_goals_per_team(teams) do
    File.stream!("data/match.csv")
    |> Stream.drop(1)
    |> Flow.from_enumerable
    |> Flow.map(&String.split(&1, ","))    
    |> Flow.reduce(fn -> Map.new end, fn(x, map) -> add_goals(map, x) end)    
    |> Flow.map(fn({team_id, goals}) -> {Map.get(teams, team_id), goals} end)    
    |> Enum.sort(fn({_, g1}, {_, g2}) -> g1 >= g2 end)
  end

  def add_goals(map, match) do
    home_team_id = Enum.at(match, 7)
    away_team_id = Enum.at(match, 8)
    map = case Enum.at(match, 9) do
      nil -> map
      goals ->         
        add_goals(map, home_team_id, parse_goals(goals))
    end    
    map = case Enum.at(match, 10) do
      nil -> map
      goals -> add_goals(map, away_team_id, parse_goals(goals))
    end
    map 
  end

  def add_goals(map, team_id, goals) do
    {_, updated_map} = Map.get_and_update(map, team_id, fn current_value ->
      case current_value do
        nil -> {nil, goals}
        current_goals -> {current_goals, current_goals + goals}
      end      
    end)
    updated_map
  end

  def parse_goals(goals) do
    case Integer.parse(goals) do 
      :error -> 0
      {value, _} -> value
    end
  end

end