defmodule DietProWeb.FoodLive.Index do
  use DietProWeb, :live_view

  alias DietPro.Diets
  alias DietPro.Diets.Food

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :foods, Diets.list_foods())}
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
    {:noreply, stream_insert(socket, :foods, food)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    food = Diets.get_food!(id)
    {:ok, _} = Diets.delete_food(food)

    {:noreply, stream_delete(socket, :foods, food)}
  end
end
