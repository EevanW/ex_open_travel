defmodule ExOpenTravel.Composers.OtaRead.Request do
  alias ExOpenTravel.Meta
  alias ExOpenTravel.Request
  alias ExOpenTravel.Request.PCIProxies.PCIBooking
  alias ExOpenTravel.Request.Document
  @action "OTA_Read"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}
  @type options :: keyword() | any()

  @doc """
  This method is used to update availability.
  """
  @spec execute(%{hotel_code: String.t()}, credentials, Meta.t(), options) ::
          {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: _} = params, %{pci_proxy: :pci_booking} = credentials, meta, opts) do
    params
    |> build_read(meta)
    |> Document.build(@action, credentials)
    |> PCIBooking.proxy_send(credentials, opts)
  end

  def execute(%{hotel_code: _} = params, credentials, meta, opts) do
    params
    |> build_read(Map.put(meta, :method, @action))
    |> Document.build(@action, credentials)
    |> Request.send(credentials, opts)
  end

  @spec build_read(%{hotel_code: String.t()}, Meta.t()) ::
          {{atom(), map | nil, list | nil}, Meta.t()}
  def build_read(%{hotel_code: hotel_code}, meta) do
    {{:"ns1:ReadRequests", nil, [{:"ns1:HotelReadRequest", %{HotelCode: "#{hotel_code}"}, nil}]},
     meta}
  end
end
