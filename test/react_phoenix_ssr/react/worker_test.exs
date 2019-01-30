defmodule ReactPhoenixSsr.React.WorkerTest do
  use ExUnit.Case, async: true

  alias ReactPhoenixSsr.React.Worker

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
      assert {:ok, response} = GenServer.call(pid, {:html, "HelloWorld", %{}})

      assert response == %{
               "markup" => "<div data-reactroot=\"\">Hello World!!!</div>",
               "error" => nil,
               "component" => "HelloWorld"
             }
    end
  end
end
