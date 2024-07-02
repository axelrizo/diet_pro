defmodule DietPro.Diets.Food do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods" do
    field :carbohydrate, :float
    field :fat, :float
    field :name, :string
    field :protein, :float
    field :calories, :float, virtual: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :protein, :fat, :carbohydrate])
    |> validate_required([:name, :protein, :fat, :carbohydrate])
  end

  def put_calories(%__MODULE__{} = food) do
    %{food | calories: get_calories(food)}
  end

  def get_calories(%__MODULE__{} = food) do
    food.protein * 4 + food.fat * 9 + food.carbohydrate * 4
  end
end
