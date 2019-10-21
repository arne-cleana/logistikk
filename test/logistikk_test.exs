defmodule LogistikkTest do
  use ExUnit.Case
  doctest Logistikk
  ExUnit.configure(exclude: [runnable: false], include: [runnable: true])

  @tag runnable: true
  test "skal behandle 1 salgshendelse" do
    {_, mottaker} = Logistikk.start()

    Logistikk.motta_salgshendelse(mottaker, {1, "brus"})

    assert_receive :behandlet_salgshendelse
  end

  @tag runnable: true
  test "skal behandle 3 salgshendelser" do
    {_, mottaker} = Logistikk.start()

    Logistikk.motta_salgshendelse(mottaker, {1, "brus"})
    Logistikk.motta_salgshendelse(mottaker, {2, "sjokolade"})
    Logistikk.motta_salgshendelse(mottaker, {3, "boller"})

    assert_receive :behandlet_salgshendelse
    assert_receive :behandlet_salgshendelse
    assert_receive :behandlet_salgshendelse
  end

  @tag runnable: true
  test "skal liste ordre" do
    {_, mottaker} = Logistikk.start()

    Logistikk.motta_salgshendelse(mottaker, {1, "brus"})
    Logistikk.motta_salgshendelse(mottaker, {2, "sjokolade"})
    Logistikk.motta_salgshendelse(mottaker, {3, "boller"})

    assert_receive :behandlet_salgshendelse
    assert_receive :behandlet_salgshendelse
    assert_receive :behandlet_salgshendelse

    Logistikk.list_ordre(mottaker)
    assert_receive :ordre_listet
  end
end
