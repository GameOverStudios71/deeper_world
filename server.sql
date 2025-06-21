
CREATE TABLE servers
 server_name TEXT,
    url TEXT,
    description_hero TEXT,
    description_full TEXT,
    verified BOOLEAN,
    category_id INTEGER,
    language_id INTEGER,
    latitude REAL,
    longitude REAL,
    country TEXT,
    region TEXT,
    city TEXT,
    owner_id INTEGER, -- User_id
    status_id INTEGER, -- Online, Offline, Maintenance
    ping_ms INTEGER,
    visited_users_lst_mounth INTEGER,
    reputation INTEGER, -- 1-5 starts
    ai_permission BOOLEAN, -- Corrigido o tipo para BOOLEAN
    ai_generated BOOLEAN,  -- Corrigido o tipo para BOOLEAN
    server_rules TEXT,
    server_cpu_info TEXT,
    server_max_users INTEGER,
    min_age INTEGER,
    content_type_id INTEGER,
    picture_box TEXT,
    picture_icon TEXT, -- Corrigido o nome da coluna
    picture_featured TEXT,
    picture_mini TEXT,
    screenshoots TEXT,
    feature_colors TEXT,
    network_id INTEGER,
    engine_id INTEGER,
    platform_version TEXT, -- Corrigido o nome da coluna
    allow_anonymous BOOLEAN,
    max_connections INTEGER,
    encryption_level TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,