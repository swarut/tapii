defmodule TapiiWeb.Router do
  use TapiiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TapiiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TapiiWeb do
    pipe_through :browser

    get "/", PageController, :home

    # Query template group - index
    live "/query_template_groups", QueryTemplateGroupLive.Index, :index
    live "/query_template_groups/new", QueryTemplateGroupLive.Index, :new
    live "/query_template_groups/:id/edit", QueryTemplateGroupLive.Index, :edit
    # Query template group - show
    live "/query_template_groups/:id", QueryTemplateGroupLive.Show, :show
    live "/query_template_groups/:id/show/edit", QueryTemplateGroupLive.Show, :edit

    # Query template - index
    live "/query_templates", QueryTemplateLive.Index, :index
    live "/query_templates/new", QueryTemplateLive.Index, :new
    live "/query_templates/:id/edit", QueryTemplateLive.Index, :edit
    # Query template - show
    live "/query_templates/:id", QueryTemplateLive.Show, :show
    live "/query_templates/:id/show/edit", QueryTemplateLive.Show, :edit

    # Scheduler - index
    live "/schedulers", SchedulerLive.Index, :index
    live "/schedulers/new", SchedulerLive.Index, :new
    live "/schedulers/:id/edit", SchedulerLive.Index, :edit
    # Scheduler - show
    live "/schedulers/:id", SchedulerLive.Show, :show
    live "/schedulers/:id/show/edit", SchedulerLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", TapiiWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:tapii, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TapiiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
