defmodule Core.Boundary.TaskValidator do
  def errors(fields) do
    []
    |> required(fields, :title, &valid_title/2)
  end

  defp required(errors, fields, required, matcher) do
    with true <- Map.has_key?(fields, required) do
      matcher.(errors, Map.fetch!(fields, required))
    else
      false -> [{"#{required} is required"} | errors]
    end
  end

  defp valid_title(errors, field) when is_binary(field) do
    with true <- String.match?(field, ~r{\S}) do
      :ok
    else
      false -> [{"title must not be empty"} | errors]
    end
  end

  defp valid_title(errors, _field), do: [{"title must be a string"} | errors]
end
