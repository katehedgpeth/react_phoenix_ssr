defmodule ReactPhoenixSsr.Renderer do
  @moduledoc """
  Public functions for rendering a react components.
  """
  use Supervisor
  alias ReactPhoenixSsr.Renderer.Worker

  @pool_name :renderer

  @pool_opts [
    name: {:local, @pool_name},
    worker_module: Worker,
    size: 4,
    max_overflow: 0
  ]

  @spec render(String.t(), map()) :: String.t()
  def render(<<component::binary>>, %{} = props) do
    {:ok, %{"markup" => markup}} = do_render(component, props)
    markup
  end

  defp do_render(component, props) do
    fn ->
      :poolboy.transaction(
        @pool_name,
        fn pid -> GenServer.call(pid, {:html, component, props}) end,
        :infinity
      )
    end
    |> Task.async()
    |> Task.await(5_000)
  end

  @spec start_link([]) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link([]) do
    {"", 0} = System.cmd("tsc", [], cd: "assets")
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl Supervisor
  def init([]) do
    children = [
      :poolboy.child_spec(@pool_name, @pool_opts, [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
