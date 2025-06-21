CREATE TABLE servers (
   owner_id INTEGER, -- User_id
   content_type_id INTEGER,
   network_id INTEGER,
   engine_id INTEGER,
   status_id INTEGER, -- Online, Offline, Maintenance 
   category_id INTEGER,
   language_id INTEGER,
   verified BOOLEAN,

   latitude REAL,
   longitude REAL,
   country VARCHAR(100),
   region VARCHAR(100),
   city VARCHAR(100),

   server_name VARCHAR(100),
   url VARCHAR(255),
   description_hero VARCHAR(255),
   description_full VARCHAR(4000),
   


   ping_ms INTEGER,
   visited_users_lst_mounth INTEGER,
   reputation INTEGER, -- 1-5 starts
   ai_permission BOOLEAN, -- Corrigido o tipo para BOOLEAN
   ai_generated BOOLEAN,  -- Corrigido o tipo para BOOLEAN
   server_rules VARCHAR(4000),
   server_cpu_info VARCHAR(255),
   server_max_users INTEGER,
   min_age INTEGER,

   picture_box TEXT,
   picture_icon TEXT, -- Corrigido o nome da coluna
   picture_featured TEXT,
   picture_mini TEXT,
   screenshoots TEXT,
   feature_colors TEXT,

   platform_version TEXT, -- Corrigido o nome da coluna
   allow_anonymous BOOLEAN,
   max_connections INTEGER,
   encryption_level TEXT,
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,