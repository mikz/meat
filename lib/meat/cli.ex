defmodule Meat.CLI do
  @default_duration 1
  @default_rate 10

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions that end up generating a table of the last _n_ issues in a github project 
  """
  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  def process(:help) do
    IO.puts """
    usage: meat <url> [ rate | #{@default_rate }] [ duration | #{@default_duration} ]
    """
    System.halt(0)
  end

  def process(args = {url, rate, duration}) do
    Meat.Attack.launch(args)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case parse do

    { [ help: true ], _, _ }
      -> :help

    { _, [ url, rate, duration ], _ } -> { url, binary_to_integer(rate), binary_to_integer(duration) }
    { _, [ url, rate ], _ } -> { url, binary_to_integer(rate), @default_duration }
    { _, [ url ], _ } -> { url, @default_rate, @default_duration }

    _ -> :help

    end
  end
end

