-- Demais Tabelas (com created_at, updated_at e correções)
CREATE TABLE users (  -- adicionei esta tabela, assumindo que ela não existia
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    -- outros campos relevantes para o usuário
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Tabelas de Listas (com UNIQUE para evitar duplicatas)
-- Tabelas de Listas (com UNIQUE para evitar duplicatas)
CREATE TABLE list_content_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content_type TEXT UNIQUE,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE list_status (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,         -- UNIQUE garante status únicos
    description TEXT
);

CREATE TABLE list_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,         -- UNIQUE garante categorias únicas
    description TEXT
);

CREATE TABLE list_languages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,         -- UNIQUE garante idiomas únicos
    description TEXT
);

CREATE TABLE list_achievement_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,          -- UNIQUE garante tipos de conquista únicos
    description TEXT
);

CREATE TABLE list_feedback_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,          -- UNIQUE garante tipos de conquista únicos
    description TEXT
);



CREATE TABLE list_engines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    engine TEXT UNIQUE,       -- UNIQUE garante engines únicos
    description TEXT
);

CREATE TABLE list_platforms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    platform TEXT UNIQUE,     -- UNIQUE garante plataformas únicas
    description TEXT
);

CREATE TABLE list_reputations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reputation TEXT UNIQUE,    -- UNIQUE garante reputações únicas
    description TEXT
);

CREATE TABLE list_networks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,         -- UNIQUE garante nomes de rede únicos
    description TEXT
);

-- Tabelas de Relacionamento (com chaves primárias compostas e ON DELETE CASCADE)
CREATE TABLE user_follows_servers (
    user_id INTEGER,
    server_id INTEGER,
    followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, server_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (server_id) REFERENCES servers(id) ON DELETE CASCADE
);

CREATE TABLE server_follows_servers (
    follower_server_id INTEGER,
    followed_server_id INTEGER,
    followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_server_id, followed_server_id),
    FOREIGN KEY (follower_server_id) REFERENCES servers(id) ON DELETE CASCADE,
    FOREIGN KEY (followed_server_id) REFERENCES servers(id) ON DELETE CASCADE
);


-- Tabela: server_invites
CREATE TABLE server_invites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    inviter_id INTEGER,
    invitee_id INTEGER,
    invite_code TEXT,
    expires_at DATETIME,
    FOREIGN KEY (server_id) REFERENCES servers(id),
    FOREIGN KEY (inviter_id) REFERENCES users(id),
    FOREIGN KEY (invitee_id) REFERENCES users(id)
);


CREATE TABLE user_recommendations ( --> 
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    recommended_server_id INTEGER,
    recommendation_score REAL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (recommended_server_id) REFERENCES servers(id)
);

-- Tabela: user_feedback
CREATE TABLE user_feedback (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    feedback_id INTEGER,
    feedback_text TEXT,
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (feedback_id) REFERENCES list_feedback_types(id)
);



-- Tabela: server_reputation
CREATE TABLE server_reputation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    reputation_score INTEGER DEFAULT 0,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (server_id) REFERENCES servers(id)
);

-- Tabela: reports
CREATE TABLE reports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reporter_id INTEGER,
    reported_user_id INTEGER,
    reported_server_id INTEGER,
    report_type TEXT,
    report_details TEXT,
    reported_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reporter_id) REFERENCES users(id),
    FOREIGN KEY (reported_user_id) REFERENCES users(id),
    FOREIGN KEY (reported_server_id) REFERENCES servers(id)
);

-- Tabela: chat_messages
CREATE TABLE chat_messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sender_id INTEGER,
    receiver_id INTEGER,
    message_text TEXT,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);

-- Tabela: challenges
CREATE TABLE challenges (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    challenge_name TEXT,
    challenge_description TEXT,
    points_reward INTEGER,
    start_date DATETIME,
    end_date DATETIME
);

-- Tabela: user_challenges
CREATE TABLE user_challenges (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    challenge_id INTEGER,
    completed BOOLEAN DEFAULT FALSE,
    completed_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (challenge_id) REFERENCES challenges(id)
);

-- Tabela: advertisements
CREATE TABLE advertisements ( --> server_advertisements,
    server_id INTEGER,
    ad_title TEXT,
    ad_description TEXT,
    start_date DATETIME,
    end_date DATETIME,
    FOREIGN KEY (server_id) REFERENCES servers(id)
);

-- Tabela: support_tickets
CREATE TABLE support_tickets ( --> user_support_tickets
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    issue_description TEXT,
    status TEXT DEFAULT 'Open',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);



-- Tabela: rewards
CREATE TABLE rewards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reward_name TEXT,
    reward_description TEXT,
    points_required INTEGER
);

-- Tabela: user_rewards
CREATE TABLE user_rewards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    reward_id INTEGER,
    claimed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (reward_id) REFERENCES rewards(id)
);


-- Tabela: user_achievements
CREATE TABLE user_achievements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    achievement_id INTEGER,
    unlocked_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(id)
);

-- Tabela: user_favorites
CREATE TABLE user_favorites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    server_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (server_id) REFERENCES servers(id)
);

-- Tabela: servers
CREATE TABLE servers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    ip_address TEXT,
    url TEXT,
    description TEXT,
    verified BOOLEAN, -- Corrigido o tipo para BOOLEAN
    category_id INTEGER,
    language_id INTEGER,
    latitude REAL,
    longitude REAL,
    country TEXT,
    region TEXT,
    city TEXT,
    owner_id INTEGER,
    status_id INTEGER,
    ping_ms INTEGER,
    registered_users INTEGER,
    visited_users INTEGER,
    reputation_id INTEGER,
    password TEXT,
    free_users_time INTEGER,
    hour_coust INTEGER,
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
    FOREIGN KEY (content_type_id) REFERENCES list_content_types(id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES list_categories(id) ON DELETE SET NULL,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (status_id) REFERENCES list_status(id) ON DELETE SET NULL,
    FOREIGN KEY (network_id) REFERENCES list_networks(id) ON DELETE SET NULL,
    FOREIGN KEY (language_id) REFERENCES list_languages(id) ON DELETE SET NULL,
    FOREIGN KEY (reputation_id) REFERENCES list_reputations(id) ON DELETE SET NULL,
    FOREIGN KEY (engine_id) REFERENCES list_engines(id) ON DELETE SET NULL
);

-- platforms_servers (com correção na chave estrangeira e timestamps)
CREATE TABLE platforms_servers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    platform_id INTEGER,
    server_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (platform_id) REFERENCES list_platforms(id) ON DELETE CASCADE, -- Corrigido o nome da tabela
    FOREIGN KEY (server_id) REFERENCES servers(id) ON DELETE CASCADE
);



-- Tabela: achievements
CREATE TABLE achievements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    points INTEGER,
    icon TEXT,
    achievement_type_id INTEGER,
    FOREIGN KEY (achievement_type_id) REFERENCES list_achievement_types(id)
);

-- Tabela: reviews
CREATE TABLE reviews ( --> server_reviews
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    user_id INTEGER,
    rating INTEGER,
    comments TEXT,
    FOREIGN KEY (server_id) REFERENCES servers(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabela: ratings
CREATE TABLE ratings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    review_id INTEGER,
    rating INTEGER,
    FOREIGN KEY (review_id) REFERENCES reviews(id)
);

-- Tabela: server_tags
CREATE TABLE server_tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    tag TEXT,
    FOREIGN KEY (server_id) REFERENCES servers(id)
);

-- Tabela: events
CREATE TABLE events ( --> server_events
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    title TEXT,
    description TEXT,
    start_time DATETIME,
    end_time DATETIME,
    is_active BOOLEAN,
    FOREIGN KEY (server_id) REFERENCES servers(id)
);

-- Tabela: alerts
CREATE TABLE alerts ( --> server_alerts
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    user_id INTEGER,
    message TEXT,
    sent_at DATETIME,
    FOREIGN KEY (server_id) REFERENCES servers(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: server_update_messages
CREATE TABLE server_update_messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER,
    update_notes TEXT,
    new_version TEXT,
    screenshoots TEXT,
    update_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (server_id) REFERENCES servers(id)
);
