-- Table des leaders d'unité
CREATE TABLE unity_leaders (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    style VARCHAR(50)
);

-- Table des membres d'unité
CREATE TABLE unity_members (
    player_id INT PRIMARY KEY,
    unity_id INT,
    accolades INT DEFAULT 0,
    points INT DEFAULT 0,
    chat_enabled BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (unity_id) REFERENCES unity_leaders(id)
);

-- Table des classements hebdomadaires
CREATE TABLE unity_rankings (
    unity_id INT,
    player_id INT,
    points INT,
    FOREIGN KEY (unity_id) REFERENCES unity_leaders(id),
    FOREIGN KEY (player_id) REFERENCES unity_members(player_id),
    PRIMARY KEY (unity_id, player_id)
);

-- Table des tâches Unity
CREATE TABLE unity_tasks (
    id INT PRIMARY KEY,
    description TEXT,
    points INT,
    accolades INT
);
