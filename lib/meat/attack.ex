defmodule Meat.Attack do

  alias HTTPotion.Response

  def launch({url, rate, duration}) do
    intervalMs = round(1000/rate)
    durationMs = duration * 1000

    { :ok, intervalRef} = :timer.apply_interval(intervalMs, Meat.Attack, :get, [url])
    { :ok, _} = :timer.apply_after(durationMs, Meat.Attack, :stop, [intervalRef])

    :timer.sleep(durationMs)
    :ok
  end

  def stop(ref) do
    { :ok, _ } = :timer.cancel(ref)
  end

  def get(url) do
    response = HTTPotion.get(url)
    IO.puts(response.body)
    case response do
    %HTTPotion.Response{body: body, status_code: status, headers: _headers} when status in 200..299 ->
      { :ok, body }
    %HTTPotion.Response{body: body, status_code: _status, headers: _headers} ->
      { :error, body }
    end
  end
  
end

