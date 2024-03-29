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
    alblum_name VARCHAR(45) NOT NULL,
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
	artist_id INT NOT NULL,
    song_id INT NOT NULL
);

CREATE TABLE songs_has_writers
(
	song_id INT NOT NULL,
    writer_id INT NOT NULL
);

-- --------------------------Create relationships using ALTER TABLE command:--------------------------------------

-- --------------------------------------One to one, One to many-----------------------------------------
-- --------------------------------------CREATE PK---------------------------------------
ALTER TABLE songs ADD CONSTRAINT songs_pk
PRIMARY KEY (song_id), MODIFY song_id INT AUTO_INCREMENT;

ALTER TABLE bands ADD CONSTRAINT band_pk
PRIMARY KEY (band_id), MODIFY band_id INT AUTO_INCREMENT;

ALTER TABLE artists ADD CONSTRAINT artist_pk
PRIMARY KEY (artist_id), MODIFY artist_id INT AUTO_INCREMENT;

ALTER TABLE alblums ADD CONSTRAINT alblums_pk
PRIMARY KEY (alblum_id), MODIFY alblum_id INT AUTO_INCREMENT;

ALTER TABLE writers ADD CONSTRAINT writer_pk
PRIMARY KEY (writer_id), MODIFY writer_id INT AUTO_INCREMENT;

ALTER TABLE publishers ADD CONSTRAINT publisher_pk
PRIMARY KEY (publisher_id), MODIFY publisher_id INT AUTO_INCREMENT;
-- -- -----------------------------------CREATE FK---------------------------------------
-- SONGS TABLE
ALTER TABLE songs ADD CONSTRAINT songs_alblums_fk
FOREIGN KEY (alblum_id) REFERENCES alblums (alblum_id);

ALTER TABLE songs ADD CONSTRAINT songs_publishers_fk
FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id);
-- ARTISTS TABLE
ALTER TABLE artists ADD CONSTRAINT artist_band_fk
FOREIGN KEY (band_id) REFERENCES bands (band_id);

-- ALBLUMS TABLE
ALTER TABLE alblums ADD CONSTRAINT alblums_band_fk
FOREIGN KEY (band_id) REFERENCES bands (band_id);

ALTER TABLE alblums ADD CONSTRAINT alblums_artists_fk
FOREIGN KEY (artist_id) REFERENCES artists (artist_id);

ALTER TABLE alblums ADD CONSTRAINT alblums_publishers_fk
FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id);

-- --------------------------------------
-- Many to many relationships:
-- --------------------------------------

-- ARTISTS CAN HAVE MANY SONGS, SONGS CAN HAVE MANY ARTISTS
-- pk setup
ALTER TABLE artist_has_songs ADD CONSTRAINT artist_has_songs_pk
PRIMARY KEY (artist_id, song_id);
-- fk setup
ALTER TABLE artist_has_songs ADD CONSTRAINT artist_has_songs_artist_fk 
FOREIGN KEY (artist_id) REFERENCES artists (artist_id);

ALTER TABLE artist_has_songs ADD CONSTRAINT artist_has_songs_song_fk 
FOREIGN KEY (song_id) REFERENCES songs (song_id);

-- WRITERS CAN WRITE MANY SONGS, SONGS CAN HAVE MANY WRITERS
-- pk setup
ALTER TABLE songs_has_writers ADD CONSTRAINT songs_has_writers_pk
PRIMARY KEY (song_id,writer_id);
-- fk setup
ALTER TABLE songs_has_writers ADD CONSTRAINT songs_has_writers_song_fk 
FOREIGN KEY (song_id) REFERENCES songs (song_id);

ALTER TABLE songs_has_writers ADD CONSTRAINT songs_has_writers_writer_fk 
FOREIGN KEY (writer_id) REFERENCES writers (writer_id);
-- *****************************************
-- * Insert Data, Out of order due to PK FK pairs.
-- * Not all real-world relevent data filled due to imput annoyance. However, requrements met.
-- *****************************************
INSERT INTO bands (band_name) VALUES -- {
    ('Coldplay'),
    ('Imagine Dragons'),
    ('Maroon 5'),
    ('Good Kid'), -- Best band to ever exist.
    ('BoyWithUke');
-- }


INSERT INTO artists (artist_name, band_id) VALUES -- {
	-- Coldplay
    ('Chris Martin', 1), 
    ('Jonny Buckland', 1), 
    ('Guy Berryman', 1), 
    ('Will Champion', 1), 
    -- Imagine Dragons
    ('Dan Reynolds', 2), 
    ('Wayne Sermon', 2), 
    ('Ben McKee', 2), 
    ('Daniel Platzman', 2), 
    -- Maroon 5
    ('Adam Levine', 3), 
    ('James Valentine', 3), 
    ('Jesse Carmichael', 3), 
    ('Mickey Madden', 3), 
    ('Matt Flynn', 3), 
    -- Good Kid
    ('Nick Frosst', 4),
    ('Jon Kereliuk', 4),
    ('Michael Kozakov', 4),
    ('David Wood', 4),
    ('Jacob Tsafatinos', 4),
    -- Independent artist
    ('Adele', NULL),
    ('Charley Yang', 5);
-- }


INSERT INTO publishers (publisher_name) VALUES -- {
    ('Universal Music Group'),
    ('Warner Music Group'),
    ('Sony Music Entertainment'),
    ('Self publishing'),
    ('TimmyFellDownTheWell'); -- Random publisher for 5 publishers.
-- }

INSERT INTO alblums (alblum_name, number_of_songs, band_id, artist_id, publisher_id) VALUES -- {
    ('Viva La Vida or Death and All His Friends', 10, 1, NULL, 1),
    ('Night Visions', 11, 2, NULL, 2),
    ('V', 14, 3, NULL, 3),
    ('25', 11, NULL, 14, 3), -- Adele's album
    ('Good Kid 3', 6, 4, NULL, 4),
	('Lucid Dreams', 14, 5, 5, 4); -- BWU alblum, shows that band_id and artist_id doesn't always have to be null as indie artists sometimes have a different name than their "brand"
-- }

INSERT INTO songs (song_name, date_released, alblum_id, publisher_id) VALUES -- {
    ('Viva La Vida', '2008-05-25', 1, 1),
    ('Violet Hill', '2008-05-25', 1, 1),
    ('Radioactive', '2012-01-24', 2, 2),
    ('Demons', '2012-01-24', 2, 2),
    ('Sugar', '2014-01-13', 3, 3),
    ('Animals', '2014-01-13', 3, 3),
    ('No Time to explain', '2023-04-14', 5, 4),
    ('Migrane', '2023-10-06', 6, 4),
    ('Hello', '2015-10-23', NULL, 3); -- Adele's song
-- }

INSERT INTO writers (first_name, last_name) VALUES -- {
    ('Chris', 'Martin'),
    ('Jonny', 'Buckland'),
    ('Guy', 'Berryman'),
    ('Will', 'Champion'),
    ('Dan', 'Reynolds'),
    ('Wayne', 'Sermon'),
    ('Ben', 'McKee'),
    ('Daniel', 'Platzman'),
    ('Adam', 'Levine'),
    ('James', 'Valentine'),
    ('Jesse', 'Carmichael'),
    ('Mickey', 'Madden'),
    ('Matt', 'Flynn'),
    ('Adele', 'Laurie Blue Adkins'),
    ('Nick', 'Frosst'),
    ('Charlie', 'Yang'); 
-- }
-- Insert data into many-to-many tables
INSERT INTO artist_has_songs (artist_id, song_id) VALUES
(1, 1),
(1, 2),
(2, 3), 
(2, 4), 
(3, 6), 
(3, 5),  
(14, 7); 

INSERT INTO songs_has_writers (song_id, writer_id) VALUES
(1, 1), (2, 1), 
(1, 2), (2, 2), 
(1, 3), (2, 3), 
(1, 4), (2, 4), 
(3, 5), (4, 5), 
(3, 6), (4, 6), 
(3, 7),(4, 7),
(3, 8), (4, 8), 
(5, 9), (6, 9), 
(5, 10),(6, 10),
(5, 11),(6, 11),
(5, 12),(6, 12),
(5, 13),(6, 13),
(6, 15); 

-- *****************************************
-- * Finally, Select to verify data
-- *****************************************
SELECT * FROM songs;
SELECT * FROM alblums;
SELECT * FROM bands;
SELECT * FROM artists;
SELECT * FROM writers;
SELECT * FROM publishers;
SELECT * FROM artist_has_songs;
SELECT * FROM songs_has_writers;









