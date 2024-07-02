defmodule DietPro.Repo.Migrations.CreateFoodsMeasures do
  use Ecto.Migration

  def change do
    create table(:foods_measures) do
      add :name, :string
      add :grams, :integer
      add :food_id, references(:foods, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:foods_measures, [:food_id])
  end
end
