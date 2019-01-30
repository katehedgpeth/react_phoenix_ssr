defmodule ReactPhoenixSsr.Renderer.Worker do
  @moduledoc """
  Spawns a node process that can render React components into HTML strings.
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    cd = Keyword.get(opts, :cd, "assets/js")
    node = System.find_executable("node")
    port = Port.open({:spawn_executable, node}, args: ["server.js"], cd: cd)

    {:ok, %{port: port, from: nil}}
  end

  def handle_call(:port, _from, state) do
    {:reply, state.port, state}
  end

  def handle_call({:html, component, props}, from, state) do
    body =
      Jason.encode!(%{
        component: component,
        props: props
      })

    Port.command(state.port, body <> "\n")

    {:noreply, Map.put(state, :from, from)}
  end

  def handle_info({_port, {:data, data}}, state) do
    GenServer.reply(state.from, data)

    {:noreply, Map.put(state, :from, nil)}
  end
end
