-- *****************************************
-- * CREATE DATABASE
-- *****************************************
DROP DATABASE IF EXISTS song_database_midterm;
CREATE DATABASE song_database_midterm;
USE song_database_midterm;

-- *****************************************
-- * CREATE TABLES
-- *****************************************
CREATE TABLE songs
(
	song_id INT NOT NULL,
    song_name VARCHAR(35) NOT NULL,
    date_released DATE NOT NULL,
    alblum_id INT,
    publisher_id INT NOT NULL
);
CREATE TABLE alblums
(
	alblum_id INT NOT NULL,
    alblum_name VARCHAR(25) NOT NULL,
    number_of_songs INT NOT NULL,
    band_id INT,
    artist_id INT,
    publisher_id INT
);
CREATE TABLE bands
(
	band_id INT NOT NULL,
    band_name VARCHAR(25) NOT NULL
);
CREATE TABLE artists
(
	artist_id INT NOT NULL,
    artist_name VARCHAR(45) NOT NULL,
    band_id INT
);
CREATE TABLE writers
(
	writer_id INT NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL
);
CREATE TABLE publishers
(
	publisher_id INT NOT NULL,
    publisher_name VARCHAR(25) NOT NULL
);


-- -----------------------------Create Many to Many relationship tables:--------------------------------------
CREATE TABLE artist_has_songs
(
	artist_artist_id INT NOT NULL,
    artist_band_id INT NOT NULL,
    songs_song_id INT NOT NULL,
    songs_alblums_id INT NOT NULL
);
CREATE TABLE songs_has_writers
(
	songs_song_id INT NOT NULL,
    songs_publisher_id INT NOT NULL,
    songs_alblum_id INT NOT NULL,
    writers_writer_id INT NOT NULL
);
-- --------------------------Create relationships using ALTER TABLE command:--------------------------------------

-- --------------------------------------One to one, One to many-----------------------------------------
-- --------------------------------------CREATE PK---------------------------------------
ALTER TABLE songs ADD CONSTRAINT songs_pk
PRIMARY KEY (song_id), MODIFY song_id INT AUTO_INCREMENT;

ALTER TABLE alblums ADD CONSTRAINT alblum_pk
PRIMARY KEY (alblum_id), MODIFY alblum_id INT AUTO_INCREMENT;

ALTER TABLE bands ADD CONSTRAINT band_pk
PRIMARY KEY (band_id), MODIFY band_id INT AUTO_INCREMENT;

ALTER TABLE artists ADD CONSTRAINT artist_pk
PRIMARY KEY (artist_id), MODIFY artist_id INT AUTO_INCREMENT;

ALTER TABLE writers ADD CONSTRAINT writer_pk
PRIMARY KEY (writer_id), MODIFY writer_id INT AUTO_INCREMENT;

ALTER TABLE publishers ADD CONSTRAINT publisher_pk
PRIMARY KEY (publisher_id), MODIFY publisher_id INT AUTO_INCREMENT;
-- -- -----------------------------------CREATE FK FOR---------------------------------------
-- SONGS TABLE
ALTER TABLE songs ADD CONSTRAINT songs_alblums_fk
FOREIGN KEY (alblum_id) REFERENCES alblums (alblum_id);

ALTER TABLE songs ADD CONSTRAINT songs_publishers_fk
FOREIGN KEY (publisher_id) REFERENCES puplishers (publisher_id);

-- ARTISTS TABLE
ALTER TABLE artists ADD CONSTRAINT artists_band_fk
FOREIGN KEY (band_id) REFERENCES band (band_id);

-- ALBLUMS TABLE
ALTER TABLE alblums ADD CONSTRAINT alblums_band_fk
FOREIGN KEY (band_id) REFERENCES band (band_id);

ALTER TABLE alblums ADD CONSTRAINT alblums_artists_fk
FOREIGN KEY (artist_id) REFERENCES artists (artist_id);

ALTER TABLE alblums ADD CONSTRAINT alblums_publishers_fk
FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id);

-- --------------------------------------
-- Many to many relatioships listed after the many to many tables
-- --------------------------------------
-- *****************************************
-- * Insert Data
-- *****************************************