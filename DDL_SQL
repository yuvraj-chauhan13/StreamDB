-- =====================================
-- SCHEMA SETUP
-- =====================================
DROP SCHEMA IF EXISTS streamdb CASCADE;
CREATE SCHEMA IF NOT EXISTS streamdb;
SET search_path TO streamdb;

-- =====================================
-- 1. CORE ENTITIES
-- =====================================

CREATE TABLE Subscription_Plan (
    plan_id SERIAL PRIMARY KEY,
    plan_time INT NOT NULL CHECK (plan_time > 0),
    currency VARCHAR(20) NOT NULL DEFAULT 'USD',
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    country VARCHAR(50),
    ad_supported BOOLEAN NOT NULL DEFAULT FALSE,
    ad_threshold INT
);

CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    country VARCHAR(50),
    user_type VARCHAR(50) NOT NULL
        CHECK (user_type IN ('free','premium','admin')),
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Artist (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    country VARCHAR(100),
    debut_year INT,
    CHECK (
        debut_year IS NULL OR
        (debut_year >= 1900 AND debut_year <= EXTRACT(YEAR FROM CURRENT_DATE))
    )
);

CREATE TABLE Label (
    label_id SERIAL PRIMARY KEY,
    label_name VARCHAR(200) NOT NULL,
    country VARCHAR(100),
    address VARCHAR(255),
    start_year INT,
    CHECK (
        start_year IS NULL OR
        (start_year >= 1900 AND start_year <= EXTRACT(YEAR FROM CURRENT_DATE))
    )
);

CREATE TABLE Song (
    song_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

CREATE TABLE Genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    parent_genre_id INT REFERENCES Genre(genre_id) ON DELETE SET NULL
);

CREATE TABLE Advertisement (
    ad_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

CREATE TABLE Guest_Session (
    session_id SERIAL PRIMARY KEY,
    ip_address VARCHAR(50),
    country VARCHAR(100),
    start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    CHECK (end_time IS NULL OR end_time >= start_time)
);

-- =====================================
-- 2. DEPENDENT ENTITIES
-- =====================================

CREATE TABLE Album (
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    release_year INT,
    edition VARCHAR(50),
    artist_id INT NOT NULL REFERENCES Artist(artist_id) ON DELETE CASCADE,
    label_id INT REFERENCES Label(label_id) ON DELETE SET NULL,
    CHECK (
        release_year IS NULL OR
        (release_year >= 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE) + 2)
    )
);

CREATE TABLE Playlist (
    playlist_id SERIAL PRIMARY KEY,
    playlist_name VARCHAR(200) NOT NULL,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    payment_mode VARCHAR(50) NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    plan_id INT NOT NULL REFERENCES Subscription_Plan(plan_id) ON DELETE CASCADE
);

CREATE TABLE Subscription (
    user_id INT PRIMARY KEY REFERENCES "User"(user_id) ON DELETE CASCADE,
    plan_id INT NOT NULL REFERENCES Subscription_Plan(plan_id) ON DELETE CASCADE,
    payment_id INT UNIQUE REFERENCES Payment(payment_id),
    start_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE Playback (
    playback_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    song_id INT NOT NULL REFERENCES Song(song_id) ON DELETE CASCADE
);

-- =====================================
-- 3. RELATIONSHIP TABLES (M:N)
-- =====================================

CREATE TABLE Following (
    user_id INT REFERENCES "User"(user_id) ON DELETE CASCADE,
    artist_id INT REFERENCES Artist(artist_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, artist_id)
);

CREATE TABLE Sung_By (
    song_id INT REFERENCES Song(song_id) ON DELETE CASCADE,
    artist_id INT REFERENCES Artist(artist_id) ON DELETE CASCADE,
    PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE Contains (
    album_id INT REFERENCES Album(album_id) ON DELETE CASCADE,
    song_id INT REFERENCES Song(song_id) ON DELETE CASCADE,
    PRIMARY KEY (album_id, song_id)
);

CREATE TABLE Playlist_Songs (
    playlist_id INT REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    song_id INT REFERENCES Song(song_id) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, song_id)
);

CREATE TABLE Classification (
    song_id INT REFERENCES Song(song_id) ON DELETE CASCADE,
    genre_id INT REFERENCES Genre(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (song_id, genre_id)
);

CREATE TABLE Review (
    user_id INT REFERENCES "User"(user_id) ON DELETE CASCADE,
    song_id INT REFERENCES Song(song_id) ON DELETE CASCADE,
    comment TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    PRIMARY KEY (user_id, song_id)
);

CREATE TABLE Targeting (
    ad_id INT REFERENCES Advertisement(ad_id) ON DELETE CASCADE,
    genre_id INT REFERENCES Genre(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (ad_id, genre_id)
);

CREATE TABLE Unlogged_User (
    session_id INT REFERENCES Guest_Session(session_id) ON DELETE CASCADE,
    song_id INT REFERENCES Song(song_id) ON DELETE CASCADE,
    PRIMARY KEY (session_id, song_id)
);

CREATE TABLE Ad_Injection (
    playback_id INT REFERENCES Playback(playback_id) ON DELETE CASCADE,
    ad_id INT REFERENCES Advertisement(ad_id) ON DELETE CASCADE,
    trigger_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playback_id, ad_id, trigger_time)
);

-- =====================================
-- 4. INDEXES
-- =====================================
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_song_title ON Song(title);
CREATE INDEX idx_playback_time ON Playback(timestamp);
CREATE INDEX idx_playback_user ON Playback(user_id);
CREATE INDEX idx_payment_user ON Payment(user_id);
