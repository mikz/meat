defmodule CliTest do
  use ExUnit.Case

  import Meat.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "20", "99"]) == { "user", 20, 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["http://echo-api.herokuapp.com", "30"]) == {"http://echo-api.herokuapp.com", 30, 1 }
  end
end
