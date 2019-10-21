defmodule Logistikk do
  @moduledoc """
  Documentation for Logistikk.
  """

  @doc """


  """

  def start do
    Task.start_link(fn -> behandle_salg([]) end)
  end

  def motta_salgshendelse(mottaker, salgs_hendelse) do
    IO.puts "\nMottar #{inspect(salgs_hendelse)}"

    send(mottaker, {self(), :ny_hendelse, salgs_hendelse})
  end

  @spec behandle_salg(any) :: no_return
  def behandle_salg(logistikk_ordre) do
    receive do
      {avsender, :ny_hendelse, salgs_hendelse} ->
        IO.puts "\nBehandler #{inspect(salgs_hendelse)}"

        send(avsender, :behandlet_salgshendelse)
        behandle_salg([salgs_hendelse | logistikk_ordre ])
      {avsender, :list_ordre} ->
        IO.puts "\nLister "
        inspect_ordre(logistikk_ordre)
        send(avsender, :ordre_listet)
        behandle_salg(logistikk_ordre)
    end
  end

  def list_ordre(mottaker) do
    send(mottaker, {self(), :list_ordre})
  end

  def inspect_ordre([head | tail]) do
    IO.inspect(head)
    inspect_ordre(tail)
  end
  def inspect_ordre([]) do  []
  end
end


