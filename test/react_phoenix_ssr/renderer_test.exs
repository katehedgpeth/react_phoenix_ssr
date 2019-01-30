defmodule ReactPhoenixSsr.RendererTest do
  use ExUnit.Case, async: true

  alias ReactPhoenixSsr.Renderer

  describe "render/2" do
    test "returns a string of HTML" do
      assert Renderer.render("HelloWorld", %{}) == "<div data-reactroot=\"\">Hello World!!!</div>"
    end
  end
end
