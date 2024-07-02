defmodule DietPro.Repo.Migrations.CreateFoodCategories do
  use Ecto.Migration

  def change do
    create table(:food_categories) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
