defmodule DietPro.DietsTest do
  use DietPro.DataCase

  alias DietPro.Diets

  describe "foods" do
    alias DietPro.Diets.Food

    import DietPro.DietsFixtures

    @invalid_attrs %{carbohydrate: nil, fat: nil, name: nil, protein: nil}

    test "list_foods/0 returns all foods" do
      food = food_fixture()
      assert Diets.list_foods() == [food]
    end

    test "get_food!/1 returns the food with given id" do
      food = food_fixture()
      assert Diets.get_food!(food.id) == food
    end

    test "create_food/1 with valid data creates a food" do
      valid_attrs = %{carbohydrate: 120.5, fat: 120.5, name: "some name", protein: 120.5}

      assert {:ok, %Food{} = food} = Diets.create_food(valid_attrs)
      assert food.carbohydrate == 120.5
      assert food.fat == 120.5
      assert food.name == "some name"
      assert food.protein == 120.5
    end

    test "create_food/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diets.create_food(@invalid_attrs)
    end

    test "update_food/2 with valid data updates the food" do
      food = food_fixture()
      update_attrs = %{carbohydrate: 456.7, fat: 456.7, name: "some updated name", protein: 456.7}

      assert {:ok, %Food{} = food} = Diets.update_food(food, update_attrs)
      assert food.carbohydrate == 456.7
      assert food.fat == 456.7
      assert food.name == "some updated name"
      assert food.protein == 456.7
    end

    test "update_food/2 with invalid data returns error changeset" do
      food = food_fixture()
      assert {:error, %Ecto.Changeset{}} = Diets.update_food(food, @invalid_attrs)
      assert food == Diets.get_food!(food.id)
    end

    test "delete_food/1 deletes the food" do
      food = food_fixture()
      assert {:ok, %Food{}} = Diets.delete_food(food)
      assert_raise Ecto.NoResultsError, fn -> Diets.get_food!(food.id) end
    end

    test "change_food/1 returns a food changeset" do
      food = food_fixture()
      assert %Ecto.Changeset{} = Diets.change_food(food)
    end
  end

  describe "food_categories" do
    alias DietPro.Diets.FoodCategory

    import DietPro.DietsFixtures

    @invalid_attrs %{f: nil, name: nil}

    test "list_food_categories/0 returns all food_categories" do
      food_category = food_category_fixture()
      assert Diets.list_food_categories() == [food_category]
    end

    test "get_food_category!/1 returns the food_category with given id" do
      food_category = food_category_fixture()
      assert Diets.get_food_category!(food_category.id) == food_category
    end

    test "create_food_category/1 with valid data creates a food_category" do
      valid_attrs = %{f: "some f", name: "some name"}

      assert {:ok, %FoodCategory{} = food_category} = Diets.create_food_category(valid_attrs)
      assert food_category.f == "some f"
      assert food_category.name == "some name"
    end

    test "create_food_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diets.create_food_category(@invalid_attrs)
    end

    test "update_food_category/2 with valid data updates the food_category" do
      food_category = food_category_fixture()
      update_attrs = %{f: "some updated f", name: "some updated name"}

      assert {:ok, %FoodCategory{} = food_category} = Diets.update_food_category(food_category, update_attrs)
      assert food_category.f == "some updated f"
      assert food_category.name == "some updated name"
    end

    test "update_food_category/2 with invalid data returns error changeset" do
      food_category = food_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Diets.update_food_category(food_category, @invalid_attrs)
      assert food_category == Diets.get_food_category!(food_category.id)
    end

    test "delete_food_category/1 deletes the food_category" do
      food_category = food_category_fixture()
      assert {:ok, %FoodCategory{}} = Diets.delete_food_category(food_category)
      assert_raise Ecto.NoResultsError, fn -> Diets.get_food_category!(food_category.id) end
    end

    test "change_food_category/1 returns a food_category changeset" do
      food_category = food_category_fixture()
      assert %Ecto.Changeset{} = Diets.change_food_category(food_category)
    end
  end
end
