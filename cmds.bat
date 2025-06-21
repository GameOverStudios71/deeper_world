mix phx.gen.live Hub Server servers verified:boolean latitude:float longitude:float country:string region:string city:string server_name:string url:string description_hero:string description_full:text ping_ms:integer visited_users_lst_mounth:integer reputation:integer ai_permission:boolean ai_generated:boolean server_rules:text server_cpu_info:string server_max_users:integer min_age:integer picture_box:text picture_icon:text picture_featured:text picture_mini:text screenshoots:text feature_colors:text platform_version:text allow_anonymous:boolean max_connections:integer encryption_level:text owner_id:references:users content_type_id:references:content_types network_id:references:networks engine_id:references:engines status_id:references:statuses category_id:references:categories language_id:references:languages


mix phx.gen.live Hub Category categories name:string
mix phx.gen.live Hub Language languages name:string
mix phx.gen.live Hub Status statuses name:string
mix phx.gen.live Hub Engine engines name:string
mix phx.gen.live Hub Network networks name:string
mix phx.gen.live Hub ContentType content_types name:string





# Tipos de Conquista e Feedback
mix phx.gen.live Hub AchievementType achievement_types name:string description:text
mix phx.gen.live Hub FeedbackType feedback_types name:string description:text

# Desafios e Recompensas
mix phx.gen.live Hub Challenge challenges challenge_name:string challenge_description:text points_reward:integer start_date:utc_datetime end_date:utc_datetime
mix phx.gen.live Hub Reward rewards reward_name:string reward_description:text points_required:integer




# Conquistas (referencia achievement_types)
mix phx.gen.live Hub Achievement achievements name:string description:text points:integer icon:string achievement_type_id:references:achievement_types

# Feedback do Usuário (referencia users e feedback_types)
mix phx.gen.live Hub UserFeedback user_feedback feedback_text:text submitted_at:utc_datetime user_id:references:users feedback_id:references:feedback_types

# Convites de Servidor (referencia servers e users)
mix phx.gen.live Hub ServerInvite server_invites invite_code:string expires_at:utc_datetime server_id:references:servers inviter_id:references:users invitee_id:references:users

# Recomendações (referencia users e servers)
mix phx.gen.live Hub UserRecommendation user_recommendations recommendation_score:float user_id:references:users recommended_server_id:references:servers

# Reputação do Servidor (referencia servers)
mix phx.gen.live Hub ServerReputation server_reputation reputation_score:integer last_updated:utc_datetime server_id:references:servers

# Denúncias (referencia users e servers)
mix phx.gen.live Hub Report reports report_type:string report_details:text reported_at:utc_datetime reporter_id:references:users reported_user_id:references:users reported_server_id:references:servers

# Anúncios (referencia servers)
mix phx.gen.live Hub ServerAdvertisement advertisements ad_title:string ad_description:text start_date:utc_datetime end_date:utc_datetime server_id:references:servers

# Tickets de Suporte (referencia users)
mix phx.gen.live Hub SupportTicket support_tickets issue_description:text status:string user_id:references:users

# Avaliações (referencia servers e users)
mix phx.gen.live Hub ServerReview reviews rating:integer comments:text server_id:references:servers user_id:references:users

# Ratings (referencia reviews)
mix phx.gen.live Hub Rating ratings rating:integer review_id:references:reviews

# Tags de Servidor (referencia servers)
mix phx.gen.live Hub ServerTag server_tags tag:string server_id:references:servers

# Eventos (referencia servers)
mix phx.gen.live Hub ServerEvent events title:string description:text start_time:utc_datetime end_time:utc_datetime is_active:boolean server_id:references:servers

# Mensagens de Atualização (referencia servers)
mix phx.gen.live Hub ServerUpdateMessage server_update_messages update_notes:text new_version:string screenshoots:text update_date:utc_datetime server_id:references:servers