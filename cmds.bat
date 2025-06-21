mix phx.gen.live Hub Server servers verified:boolean latitude:float longitude:float country:string region:string city:string server_name:string url:string description_hero:string description_full:text ping_ms:integer visited_users_lst_mounth:integer reputation:integer ai_permission:boolean ai_generated:boolean server_rules:text server_cpu_info:string server_max_users:integer min_age:integer picture_box:text picture_icon:text picture_featured:text picture_mini:text screenshoots:text feature_colors:text platform_version:text allow_anonymous:boolean max_connections:integer encryption_level:text owner_id:references:users content_type_id:references:content_types network_id:references:networks engine_id:references:engines status_id:references:statuses category_id:references:categories language_id:references:languages


mix phx.gen.live Hub Category categories name:string
mix phx.gen.live Hub Language languages name:string
mix phx.gen.live Hub Status statuses name:string
mix phx.gen.live Hub Engine engines name:string
mix phx.gen.live Hub Network networks name:string
mix phx.gen.live Hub ContentType content_types name:string