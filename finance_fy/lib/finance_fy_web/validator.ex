defmodule FinanceFyWeb.Validator do
@moduledoc """
  helper module to valid request params
"""
  alias Ecto.Changeset
  import Ecto.Changeset

  def validate_request(types, params) do
    required_keys = Map.keys(types)

    {%{}, types}
    |> cast(params, required_keys)
    |> validate_required(required_keys)
    |> handle_changeset()
  end

  defp handle_changeset(%Changeset{valid?: true} = changeset), do: {:ok, changeset.changes}
  defp handle_changeset(%Changeset{valid?: false} = changeset), do: {:error, changeset}
end
