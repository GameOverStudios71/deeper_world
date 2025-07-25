defmodule DeeperHubWeb.Router do
  use DeeperHubWeb, :router

  import DeeperHubWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DeeperHubWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DeeperHubWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", DeeperHubWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:deeper_hub, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DeeperHubWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", DeeperHubWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{DeeperHubWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit

    end

    post "/users/log_in", UserSessionController, :create

  end

  scope "/", DeeperHubWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{DeeperHubWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      # CRUD Routes
      live "/servers", ServerLive.Index, :index
      live "/servers/new", ServerLive.Index, :new
      live "/servers/:id/edit", ServerLive.Index, :edit
      live "/servers/:id", ServerLive.Show, :show
      live "/servers/:id/show/edit", ServerLive.Show, :edit

      live "/categories", CategoryLive.Index, :index
      live "/categories/new", CategoryLive.Index, :new
      live "/categories/:id/edit", CategoryLive.Index, :edit
      live "/categories/:id", CategoryLive.Show, :show
      live "/categories/:id/show/edit", CategoryLive.Show, :edit

      live "/languages", LanguageLive.Index, :index
      live "/languages/new", LanguageLive.Index, :new
      live "/languages/:id/edit", LanguageLive.Index, :edit
      live "/languages/:id", LanguageLive.Show, :show
      live "/languages/:id/show/edit", LanguageLive.Show, :edit

      live "/statuses", StatusLive.Index, :index
      live "/statuses/new", StatusLive.Index, :new
      live "/statuses/:id/edit", StatusLive.Index, :edit
      live "/statuses/:id", StatusLive.Show, :show
      live "/statuses/:id/show/edit", StatusLive.Show, :edit

      live "/engines", EngineLive.Index, :index
      live "/engines/new", EngineLive.Index, :new
      live "/engines/:id/edit", EngineLive.Index, :edit
      live "/engines/:id", EngineLive.Show, :show
      live "/engines/:id/show/edit", EngineLive.Show, :edit

      live "/networks", NetworkLive.Index, :index
      live "/networks/new", NetworkLive.Index, :new
      live "/networks/:id/edit", NetworkLive.Index, :edit
      live "/networks/:id", NetworkLive.Show, :show
      live "/networks/:id/show/edit", NetworkLive.Show, :edit

      live "/content_types", ContentTypeLive.Index, :index
      live "/content_types/new", ContentTypeLive.Index, :new
      live "/content_types/:id/edit", ContentTypeLive.Index, :edit
      live "/content_types/:id", ContentTypeLive.Show, :show
      live "/content_types/:id/show/edit", ContentTypeLive.Show, :edit


    live "/achievement_types", AchievementTypeLive.Index, :index
    live "/achievement_types/new", AchievementTypeLive.Index, :new
    live "/achievement_types/:id/edit", AchievementTypeLive.Index, :edit

    live "/achievement_types/:id", AchievementTypeLive.Show, :show
    live "/achievement_types/:id/show/edit", AchievementTypeLive.Show, :edit


    live "/feedback_types", FeedbackTypeLive.Index, :index
    live "/feedback_types/new", FeedbackTypeLive.Index, :new
    live "/feedback_types/:id/edit", FeedbackTypeLive.Index, :edit

    live "/feedback_types/:id", FeedbackTypeLive.Show, :show
    live "/feedback_types/:id/show/edit", FeedbackTypeLive.Show, :edit


    live "/challenges", ChallengeLive.Index, :index
    live "/challenges/new", ChallengeLive.Index, :new
    live "/challenges/:id/edit", ChallengeLive.Index, :edit

    live "/challenges/:id", ChallengeLive.Show, :show
    live "/challenges/:id/show/edit", ChallengeLive.Show, :edit


    live "/rewards", RewardLive.Index, :index
    live "/rewards/new", RewardLive.Index, :new
    live "/rewards/:id/edit", RewardLive.Index, :edit

    live "/rewards/:id", RewardLive.Show, :show
    live "/rewards/:id/show/edit", RewardLive.Show, :edit


    live "/achievements", AchievementLive.Index, :index
    live "/achievements/new", AchievementLive.Index, :new
    live "/achievements/:id/edit", AchievementLive.Index, :edit

    live "/achievements/:id", AchievementLive.Show, :show
    live "/achievements/:id/show/edit", AchievementLive.Show, :edit



    live "/user_feedback", UserFeedbackLive.Index, :index
    live "/user_feedback/new", UserFeedbackLive.Index, :new
    live "/user_feedback/:id/edit", UserFeedbackLive.Index, :edit

    live "/user_feedback/:id", UserFeedbackLive.Show, :show
    live "/user_feedback/:id/show/edit", UserFeedbackLive.Show, :edit



    live "/server_invites", ServerInviteLive.Index, :index
    live "/server_invites/new", ServerInviteLive.Index, :new
    live "/server_invites/:id/edit", ServerInviteLive.Index, :edit

    live "/server_invites/:id", ServerInviteLive.Show, :show
    live "/server_invites/:id/show/edit", ServerInviteLive.Show, :edit



    live "/user_recommendations", UserRecommendationLive.Index, :index
    live "/user_recommendations/new", UserRecommendationLive.Index, :new
    live "/user_recommendations/:id/edit", UserRecommendationLive.Index, :edit

    live "/user_recommendations/:id", UserRecommendationLive.Show, :show
    live "/user_recommendations/:id/show/edit", UserRecommendationLive.Show, :edit



    live "/server_reputation", ServerReputationLive.Index, :index
    live "/server_reputation/new", ServerReputationLive.Index, :new
    live "/server_reputation/:id/edit", ServerReputationLive.Index, :edit

    live "/server_reputation/:id", ServerReputationLive.Show, :show
    live "/server_reputation/:id/show/edit", ServerReputationLive.Show, :edit



    live "/reports", ReportLive.Index, :index
    live "/reports/new", ReportLive.Index, :new
    live "/reports/:id/edit", ReportLive.Index, :edit

    live "/reports/:id", ReportLive.Show, :show
    live "/reports/:id/show/edit", ReportLive.Show, :edit



    live "/advertisements", ServerAdvertisementLive.Index, :index
    live "/advertisements/new", ServerAdvertisementLive.Index, :new
    live "/advertisements/:id/edit", ServerAdvertisementLive.Index, :edit

    live "/advertisements/:id", ServerAdvertisementLive.Show, :show
    live "/advertisements/:id/show/edit", ServerAdvertisementLive.Show, :edit




    live "/support_tickets", SupportTicketLive.Index, :index
    live "/support_tickets/new", SupportTicketLive.Index, :new
    live "/support_tickets/:id/edit", SupportTicketLive.Index, :edit

    live "/support_tickets/:id", SupportTicketLive.Show, :show
    live "/support_tickets/:id/show/edit", SupportTicketLive.Show, :edit


    live "/reviews", ServerReviewLive.Index, :index
    live "/reviews/new", ServerReviewLive.Index, :new
    live "/reviews/:id/edit", ServerReviewLive.Index, :edit

    live "/reviews/:id", ServerReviewLive.Show, :show
    live "/reviews/:id/show/edit", ServerReviewLive.Show, :edit



    live "/ratings", RatingLive.Index, :index
    live "/ratings/new", RatingLive.Index, :new
    live "/ratings/:id/edit", RatingLive.Index, :edit

    live "/ratings/:id", RatingLive.Show, :show
    live "/ratings/:id/show/edit", RatingLive.Show, :edit



    live "/server_tags", ServerTagLive.Index, :index
    live "/server_tags/new", ServerTagLive.Index, :new
    live "/server_tags/:id/edit", ServerTagLive.Index, :edit

    live "/server_tags/:id", ServerTagLive.Show, :show
    live "/server_tags/:id/show/edit", ServerTagLive.Show, :edit


    live "/events", ServerEventLive.Index, :index
    live "/events/new", ServerEventLive.Index, :new
    live "/events/:id/edit", ServerEventLive.Index, :edit

    live "/events/:id", ServerEventLive.Show, :show
    live "/events/:id/show/edit", ServerEventLive.Show, :edit



    live "/server_update_messages", ServerUpdateMessageLive.Index, :index
    live "/server_update_messages/new", ServerUpdateMessageLive.Index, :new
    live "/server_update_messages/:id/edit", ServerUpdateMessageLive.Index, :edit

    live "/server_update_messages/:id", ServerUpdateMessageLive.Show, :show
    live "/server_update_messages/:id/show/edit", ServerUpdateMessageLive.Show, :edit


    end
  end

  scope "/", DeeperHubWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{DeeperHubWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
