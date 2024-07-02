defmodule DietProWeb.FoodCategoryLiveTest do
  use DietProWeb.ConnCase

  import Phoenix.LiveViewTest
  import DietPro.DietsFixtures

  @create_attrs %{f: "some f", name: "some name"}
  @update_attrs %{f: "some updated f", name: "some updated name"}
  @invalid_attrs %{f: nil, name: nil}

  defp create_food_category(_) do
    food_category = food_category_fixture()
    %{food_category: food_category}
  end

  describe "Index" do
    setup [:create_food_category]

    test "lists all food_categories", %{conn: conn, food_category: food_category} do
      {:ok, _index_live, html} = live(conn, ~p"/food_categories")

      assert html =~ "Listing Food categories"
      assert html =~ food_category.f
    end

    test "saves new food_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/food_categories")

      assert index_live |> element("a", "New Food category") |> render_click() =~
               "New Food category"

      assert_patch(index_live, ~p"/food_categories/new")

      assert index_live
             |> form("#food_category-form", food_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#food_category-form", food_category: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_categories")

      html = render(index_live)
      assert html =~ "Food category created successfully"
      assert html =~ "some f"
    end

    test "updates food_category in listing", %{conn: conn, food_category: food_category} do
      {:ok, index_live, _html} = live(conn, ~p"/food_categories")

      assert index_live |> element("#food_categories-#{food_category.id} a", "Edit") |> render_click() =~
               "Edit Food category"

      assert_patch(index_live, ~p"/food_categories/#{food_category}/edit")

      assert index_live
             |> form("#food_category-form", food_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#food_category-form", food_category: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_categories")

      html = render(index_live)
      assert html =~ "Food category updated successfully"
      assert html =~ "some updated f"
    end

    test "deletes food_category in listing", %{conn: conn, food_category: food_category} do
      {:ok, index_live, _html} = live(conn, ~p"/food_categories")

      assert index_live |> element("#food_categories-#{food_category.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#food_categories-#{food_category.id}")
    end
  end

  describe "Show" do
    setup [:create_food_category]

    test "displays food_category", %{conn: conn, food_category: food_category} do
      {:ok, _show_live, html} = live(conn, ~p"/food_categories/#{food_category}")

      assert html =~ "Show Food category"
      assert html =~ food_category.f
    end

    test "updates food_category within modal", %{conn: conn, food_category: food_category} do
      {:ok, show_live, _html} = live(conn, ~p"/food_categories/#{food_category}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Food category"

      assert_patch(show_live, ~p"/food_categories/#{food_category}/show/edit")

      assert show_live
             |> form("#food_category-form", food_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#food_category-form", food_category: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/food_categories/#{food_category}")

      html = render(show_live)
      assert html =~ "Food category updated successfully"
      assert html =~ "some updated f"
    end
  end
end
