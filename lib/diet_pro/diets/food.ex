defmodule DietPro.Diets.Food do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods" do
    field :carbohydrate, :float
    field :fat, :float
    field :name, :string
    field :protein, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :protein, :fat, :carbohydrate])
    |> validate_required([:name, :protein, :fat, :carbohydrate])
  end
end
