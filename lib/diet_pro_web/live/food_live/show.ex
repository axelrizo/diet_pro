defmodule DietProWeb.FoodLive.Show do
  use DietProWeb, :live_view

  alias DietPro.Diets

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:food_categories, Diets.list_food_categories())

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:food, Diets.get_food!(id))}
  end

  defp page_title(:show), do: "Show Food"
  defp page_title(:edit), do: "Edit Food"
end
