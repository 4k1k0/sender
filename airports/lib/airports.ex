defmodule Airports do
  alias NimbleCSV.RFC4180, as: CSV

  def airports_csv() do
    Application.app_dir(:airports, "/priv/airports.csv")
  end

  def open_airports() do
    airports_csv()
    |> File.stream!
    |> Flow.from_enumerable
    |> Flow.map(fn row ->
      [row] = CSV.parse_string(row, skip_headers: false)
      %{
        id: :binary.copy(Enum.at(row, 0)),
        type: :binary.copy(Enum.at(row, 2)),
        name: :binary.copy(Enum.at(row, 3)),
        country: :binary.copy(Enum.at(row, 8)),
      }
    end)
    |> Flow.reject(&(&1.type == "closed"))
    |> Enum.to_list
  end

end
