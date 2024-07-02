defmodule DietProWeb.FoodLive.Index do
  use DietProWeb, :live_view

  alias DietPro.Diets
  alias DietPro.Diets.Food

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream(:foods, Diets.list_foods())
      |> assign(:food_categories, Diets.list_food_categories())

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Food")
    |> assign(:food, Diets.get_food!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Food")
    |> assign(:food, %Food{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Foods")
    |> assign(:food, nil)
  end

  @impl true
  def handle_info({DietProWeb.FoodLive.FormComponent, {:saved, food}}, socket) do
    food =
      food
      |> Food.put_calories()
      |> DietPro.Repo.preload(:food_category)

    socket = stream_insert(socket, :foods, food)

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    food = Diets.get_food!(id)
    {:ok, _} = Diets.delete_food(food)

    {:noreply, stream_delete(socket, :foods, food)}
  end
end
