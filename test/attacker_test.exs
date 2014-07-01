defmodule AttackerTest do
  use ExUnit.Case

  import Meat.Attacker, only: [ request: 2 ]

  test "returns status of given call" do
    assert request(:get, "http://google.com") == 200
  end
end
