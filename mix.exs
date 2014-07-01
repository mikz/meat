defmodule Meat.Mixfile do
  use Mix.Project

  def project do
    [
      app: :meat,
      escript_main_module: Meat.CLI,
      version: "0.0.1",
      elixir: "~> 0.14.2",
      deps: deps
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [ applications: [ :inets ],
      mod: { Meat, [] } ]
  end

  # List all dependencies in the format:
  #
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      # { :httpotion, git: "https://github.com/myfreeweb/httpotion.git" }
    ]
  end
end
