defmodule Meat.Attack do
  def launch({url, rate, duration}) do
    intervalMs = round(1000/rate)
    durationMs = duration * 1000

    attacker = Meat.Attack.start(url)
    { :ok, intervalRef} = :timer.apply_interval(intervalMs, :gen_server, :call, [attacker, :get])
    { :ok, _} = :timer.apply_after(durationMs, Meat.Attack, :stop, [attacker, intervalRef])

    :timer.sleep(durationMs)
    :ok
  end

  def stop(attacker, ref) do
    { :ok, _ } = :timer.cancel(ref)
    :gen_server.call(attacker, :stop)
  end
  
  def start(url) do
    { :ok, pid } = :gen_server.start_link(Meat.Attacker, [url], [])
    pid
  end
end

