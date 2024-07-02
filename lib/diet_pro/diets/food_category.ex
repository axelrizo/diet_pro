defmodule DietPro.Diets.FoodCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_categories" do
    field :name, :string

    timestamps(type: :utc_datetime)

    has_many :foods, DietPro.Diets.Food
  end

  @doc false
  def changeset(food_category, attrs) do
    food_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
