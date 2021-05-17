defmodule TD.Core.CommandTest do
  use ExUnit.Case, async: true

  alias TD.Core.Command

  describe "add_response/2" do
    test "should add the responses" do
      result =
        Command.new(type: :add)
        |> Command.add_response("first")
        |> Command.add_response("second")

      assert result.response == ["first", "second"]
      assert result.status == :ok
    end
  end

  describe "add_error" do
    test "should update the status from :ok to :error" do
      result =
        Command.new(type: :add)
        |> Command.add_response("first")
        |> Command.add_response("second")
        |> Command.add_error("oops")
        |> Command.add_error("it broke")

      assert result.response == ["oops", "it broke"]
      assert result.status == :error
    end
  end
end
