defmodule DietPro.Diets do
  @moduledoc """
  The Diets context.
  """

  import Ecto.Query, warn: false
  alias DietPro.Repo

  alias DietPro.Diets.Food

  @doc """
  Returns the list of foods.

  ## Examples

      iex> list_foods()
      [%Food{}, ...]

  """
  def list_foods do
    Food
    |> preload(:food_category)
    |> Repo.all()
    |> Enum.map(&Food.put_calories/1)
  end

  @doc """
  Gets a single food.

  Raises `Ecto.NoResultsError` if the Food does not exist.

  ## Examples

      iex> get_food!(123)
      %Food{}

      iex> get_food!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food!(id) do
    Food
    |> preload(:food_category)
    |> Repo.get!(id)
    |> Food.put_calories()
  end

  @doc """
  Creates a food.

  ## Examples

      iex> create_food(%{field: value})
      {:ok, %Food{}}

      iex> create_food(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food(attrs \\ %{}) do
    %Food{}
    |> Food.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food.

  ## Examples

      iex> update_food(food, %{field: new_value})
      {:ok, %Food{}}

      iex> update_food(food, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food(%Food{} = food, attrs) do
    food
    |> Food.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food.

  ## Examples

      iex> delete_food(food)
      {:ok, %Food{}}

      iex> delete_food(food)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food(%Food{} = food) do
    Repo.delete(food)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food changes.

  ## Examples

      iex> change_food(food)
      %Ecto.Changeset{data: %Food{}}

  """
  def change_food(%Food{} = food, attrs \\ %{}) do
    Food.changeset(food, attrs)
  end

  alias DietPro.Diets.FoodCategory

  @doc """
  Returns the list of food_categories.

  ## Examples

      iex> list_food_categories()
      [%FoodCategory{}, ...]

  """
  def list_food_categories do
    Repo.all(FoodCategory)
  end

  @doc """
  Gets a single food_category.

  Raises `Ecto.NoResultsError` if the Food category does not exist.

  ## Examples

      iex> get_food_category!(123)
      %FoodCategory{}

      iex> get_food_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_category!(id), do: Repo.get!(FoodCategory, id)

  @doc """
  Creates a food_category.

  ## Examples

      iex> create_food_category(%{field: value})
      {:ok, %FoodCategory{}}

      iex> create_food_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_category(attrs \\ %{}) do
    %FoodCategory{}
    |> FoodCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_category.

  ## Examples

      iex> update_food_category(food_category, %{field: new_value})
      {:ok, %FoodCategory{}}

      iex> update_food_category(food_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_category(%FoodCategory{} = food_category, attrs) do
    food_category
    |> FoodCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_category.

  ## Examples

      iex> delete_food_category(food_category)
      {:ok, %FoodCategory{}}

      iex> delete_food_category(food_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_category(%FoodCategory{} = food_category) do
    Repo.delete(food_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_category changes.

  ## Examples

      iex> change_food_category(food_category)
      %Ecto.Changeset{data: %FoodCategory{}}

  """
  def change_food_category(%FoodCategory{} = food_category, attrs \\ %{}) do
    FoodCategory.changeset(food_category, attrs)
  end
end
