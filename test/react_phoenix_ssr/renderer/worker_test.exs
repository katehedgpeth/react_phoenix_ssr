defmodule ReactPhoenixSsr.Renderer.WorkerTest do
  use ExUnit.Case, async: true

  alias ReactPhoenixSsr.Renderer.Worker

  describe "start_link/1" do
    test "starts a node process" do
      assert {:ok, pid} = Worker.start_link([])

      name =
        pid
        |> GenServer.call(:port)
        |> Port.info()
        |> Keyword.fetch!(:name)
        |> to_string()

      assert name =~ "/node"
    end
  end

  describe "handle_call({:html, _, _})" do
    test "renders a component to a string" do
      assert {:ok, pid} = Worker.start_link([])
      rendered = GenServer.call(pid, {:html, "HelloWorld", %{}})
      assert rendered == "<div>Hello World!!!</div>"
    end
  end
end
