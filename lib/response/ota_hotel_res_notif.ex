defmodule ExOpenTravel.Response.OtaHotelResNotif do
  @behaviour ExOpenTravel.Response.Converter
  alias ExOpenTravel.Response.Converter

  @list_nodes []

  def list_nodes, do: @list_nodes
  def convert(struct), do: Converter.convert(struct, @list_nodes)
end
