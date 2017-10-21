defmodule OctoberTalksTest do
  use ExUnit.Case
  doctest OctoberTalks

  test "greets the world" do
    assert OctoberTalks.hello() == :world
  end
  
  test "el 2 es par" do
    assert OctoberTalks.es_par?(2) == true
  end

  test "el 301 no es par" do
    assert OctoberTalks.es_par?(301) == false
  end
  
  test "solo 200 y 1004 son pares" do
    assert OctoberTalks.solo_pares_ordenados([3, 903, 1004, 9999, 200]) == [200, 1004]
  end	

  test "encontramos a Juventus" do  
    assert Map.get(OctoberTalks.Futbol.get_teams, "9885") == "Juventus"
  end

end
