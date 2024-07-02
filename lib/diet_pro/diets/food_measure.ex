defmodule DietPro.Diets.FoodMeasure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods_measures" do
    field :grams, :integer
    field :name, :string
    field :food_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food_measure, attrs) do
    food_measure
    |> cast(attrs, [:name, :grams, :food_id])
    |> validate_required([:name, :grams, :food_id])
  end
end
