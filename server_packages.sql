CREATE TABLE achievement_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,          -- UNIQUE garante tipos de conquista únicos
    description TEXT
);

CREATE TABLE feedback_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,          -- UNIQUE garante tipos de conquista únicos
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
    FOREIGN KEY (feedback_id) REFERENCES feedback_types(id)
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
    FOREIGN KEY (achievement_type_id) REFERENCES achievement_types(id)
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
