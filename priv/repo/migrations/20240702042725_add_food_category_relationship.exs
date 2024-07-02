defmodule DietPro.Repo.Migrations.AddFoodCategoryRelationship do
  use Ecto.Migration

  def change do
    alter table(:foods) do
      add :food_category_id, references(:food_categories, on_delete: :nothing)
    end
  end
end
