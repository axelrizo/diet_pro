defmodule DietProWeb.FoodCategoryLive.FormComponent do
  use DietProWeb, :live_component

  alias DietPro.Diets

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage food_category records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="food_category-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:f]} type="text" label="F" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Food category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{food_category: food_category} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Diets.change_food_category(food_category))
     end)}
  end

  @impl true
  def handle_event("validate", %{"food_category" => food_category_params}, socket) do
    changeset = Diets.change_food_category(socket.assigns.food_category, food_category_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"food_category" => food_category_params}, socket) do
    save_food_category(socket, socket.assigns.action, food_category_params)
  end

  defp save_food_category(socket, :edit, food_category_params) do
    case Diets.update_food_category(socket.assigns.food_category, food_category_params) do
      {:ok, food_category} ->
        notify_parent({:saved, food_category})

        {:noreply,
         socket
         |> put_flash(:info, "Food category updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_food_category(socket, :new, food_category_params) do
    case Diets.create_food_category(food_category_params) do
      {:ok, food_category} ->
        notify_parent({:saved, food_category})

        {:noreply,
         socket
         |> put_flash(:info, "Food category created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
