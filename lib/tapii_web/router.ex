defmodule TapiiWeb.Router do
  use TapiiWeb, :router

  import TapiiWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TapiiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
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

    # Scheduler subscription - index
    live "/scheduler_substitutions", SchedulerSubstitutionLive.Index, :index
    live "/scheduler_substitutions/new", SchedulerSubstitutionLive.Index, :new
    live "/scheduler_substitutions/:id/edit", SchedulerSubstitutionLive.Index, :edit
    # Scheduler subscription - show
    live "/scheduler_substitutions/:id", SchedulerSubstitutionLive.Show, :show
    live "/scheduler_substitutions/:id/show/edit", SchedulerSubstitutionLive.Show, :edit

    # History - index
    live "/histories", HistoryLive.Index, :index
    live "/histories/new", HistoryLive.Index, :new
    live "/histories/:id/edit", HistoryLive.Index, :edit
    # History - show
    live "/histories/:id", HistoryLive.Show, :show
    live "/histories/:id/show/edit", HistoryLive.Show, :edit
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

  ## Authentication routes

  scope "/", TapiiWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{TapiiWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserLive.UserRegistrationLive, :new
      live "/users/log_in", UserLive.UserLoginLive, :new
      live "/users/reset_password", UserLive.UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserLive.UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", TapiiWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{TapiiWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserLive.UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserLive.UserSettingsLive, :confirm_email
    end
  end

  scope "/", TapiiWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{TapiiWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserLive.UserConfirmationLive, :edit
      live "/users/confirm", UserLive.UserConfirmationInstructionsLive, :new
    end
  end
end
