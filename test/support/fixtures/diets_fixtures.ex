defmodule DietPro.DietsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DietPro.Diets` context.
  """

  @doc """
  Generate a food.
  """
  def food_fixture(attrs \\ %{}) do
    {:ok, food} =
      attrs
      |> Enum.into(%{
        carbohydrate: 120.5,
        fat: 120.5,
        name: "some name",
        protein: 120.5
      })
      |> DietPro.Diets.create_food()

    food
  end
end
