defmodule Wabanex.IMC do
  def calculate(filename) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    content
    |> String.split("\n")
    |> Enum.map(fn line -> parse_line(line) end)
  end

  defp handle_file({:error, _reason}) do
    {:error, "Erro ao abrir o arquivo"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
    |> IO.inspect()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
