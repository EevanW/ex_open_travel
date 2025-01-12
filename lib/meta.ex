defmodule ExOpenTravel.Meta do
  defstruct request: nil,
            response: nil,
            method: nil,
            started_at: nil,
            finished_at: nil,
            errors: []

  @type t :: %__MODULE__{
               request: String.t(),
               response: String.t(),
               method: String.t(),
               started_at: DateTime.t(),
               finished_at: DateTime.t(),
               errors: list()
             }
end