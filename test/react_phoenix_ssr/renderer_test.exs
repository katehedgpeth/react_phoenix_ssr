defmodule ReactPhoenixSsr.ReactTest do
  use ExUnit.Case, async: true

  alias ReactPhoenixSsr.React

  describe "render/2" do
    test "returns a string of HTML" do
      assert React.render("HelloWorld", %{}) == "<div data-reactroot=\"\">Hello World!!!</div>"
    end
  end
end
