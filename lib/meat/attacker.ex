defmodule Meat.Attacker do
  use GenServer.Behaviour

  def init(url) do
    { :ok, url }
  end

  def handle_cast(:get, plan = [url | rest]) do
    response = HTTPotion.get(url)
    IO.puts(response.body)
    case response do
    %HTTPotion.Response{body: body, status_code: status, headers: _headers} when status in 200..299 ->
      { :noreply, [url] }
    %HTTPotion.Response{body: body, status_code: status, headers: _headers} ->
      { :noreply, [url]}
    end
  end

  def handle_call(:stop, _from, plan) do
    IO.puts("Stopping")
    { :stop, :normal, []}
  end
  
end

