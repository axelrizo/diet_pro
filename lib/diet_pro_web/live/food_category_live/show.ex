defmodule DietProWeb.FoodCategoryLive.Show do
  use DietProWeb, :live_view

  alias DietPro.Diets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:food_category, Diets.get_food_category!(id))}
  end

  defp page_title(:show), do: "Show Food category"
  defp page_title(:edit), do: "Edit Food category"
end
