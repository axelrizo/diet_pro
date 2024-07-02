defmodule DietProWeb.FoodCategoryLive.Index do
  use DietProWeb, :live_view

  alias DietPro.Diets
  alias DietPro.Diets.FoodCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :food_categories, Diets.list_food_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Food category")
    |> assign(:food_category, Diets.get_food_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Food category")
    |> assign(:food_category, %FoodCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Food categories")
    |> assign(:food_category, nil)
  end

  @impl true
  def handle_info({DietProWeb.FoodCategoryLive.FormComponent, {:saved, food_category}}, socket) do
    {:noreply, stream_insert(socket, :food_categories, food_category)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    food_category = Diets.get_food_category!(id)
    {:ok, _} = Diets.delete_food_category(food_category)

    {:noreply, stream_delete(socket, :food_categories, food_category)}
  end
end
