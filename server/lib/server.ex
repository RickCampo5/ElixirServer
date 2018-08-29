defmodule Server do
  @moduledoc """
  Documentation for Server.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Server.hello()
      :world

  """
  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    default_opts
  end

  def call(conn, _opts) do
    IO.puts "Waiting Response"
    response = HTTPotion.get "https://swapi.co/api/people/1/"
    json = Poison.Parser.parse!(response.body)
    page_contents = EEx.eval_file("templates/show.eex", [json_name: json["name"], json_gender: json["gender"], json_birth: json["birth_year"], json_height: json["height"], json_mass: json["mass"]])
    Plug.Conn.send_resp(conn, 200, page_contents)
  end
end
