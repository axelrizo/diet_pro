defmodule DietProWeb.Router do
  use DietProWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DietProWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DietProWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/foods", FoodLive.Index, :index
    live "/foods/new", FoodLive.Index, :new
    live "/foods/:id/edit", FoodLive.Index, :edit

    live "/foods/:id", FoodLive.Show, :show
    live "/foods/:id/show/edit", FoodLive.Show, :edit

    live "/food_categories", FoodCategoryLive.Index, :index
    live "/food_categories/new", FoodCategoryLive.Index, :new
    live "/food_categories/:id/edit", FoodCategoryLive.Index, :edit

    live "/food_categories/:id", FoodCategoryLive.Show, :show
    live "/food_categories/:id/show/edit", FoodCategoryLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", DietProWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:diet_pro, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DietProWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
