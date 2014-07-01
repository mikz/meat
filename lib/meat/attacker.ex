defmodule Meat.Attacker do
  use GenServer

  def init(url) do
    { :ok, url }
  end

  def handle_cast(method, plan = [url | rest]) do
    status = request(method, url)
    case status do
      200..299 ->
      { :noreply, [url] }
      _ ->
      { :noreply, [url]}
    end
  end

  def request(method, url) do
    url = httpc_url(url)

    case  :httpc.request(method, { url, []}, [], [{ :sync, false }]) do
      { :ok, {{_version, status, _reason}, _headers, body}} -> status
      { :error, error } -> error
      { :ok, pid } -> pid
    end
  end

  def httpc_url(url) when is_list(url) do
    url
  end

  def httpc_url(url) when is_bitstring(url) do
    String.to_char_list(url)
  end

  def handle_call(:stop, _from, plan) do
    IO.puts("Stopping")
    { :stop, :normal, []}
  end
  
end

