/*
This sql file serves as the file for the submission for your team's Final Group Project

Change the name of this file to include
your team member names
*/

/*
List here:
1) PM: Amandaleeanne Schock
2) Amandaleeanne Schock: All
*/

/*
Right below here, list your team's updated 
and best sql code for the midterm group project
i.e.
-creating tables
-creating constraints
insert statements
select statements to list what was inserted
in the tables
*/
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
    ('25', 11, NULL, 19, 3), -- Adele's alblum
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

/* PROBLEM 6
-List right below this set of comments, the code for the Programming Problem - Indexes
-Keep this set of comments in your team's submission
*/
CREATE INDEX idx_alblum_band_artist_numSong ON alblums(alblum_id, band_id, artist_id,number_of_songs);
CREATE INDEX idx_date_released ON songs(date_released);



/* 
-List right below this set of comments, the code for the Programming Problem - Multi-table Query
-Keep this set of comments in your team's submission

Clauses that MUST be used
Select
From
Group By
Where
Having
Order By
In the Select Clause, you need to use a built-in  Function offered by SQL 
*/

-- Which publishers have released alblums with more than 3 songs?
SELECT p.publisher_name, COUNT(a.alblum_id) AS num_alblums
FROM publishers p
JOIN alblums a ON p.publisher_id = a.publisher_id
WHERE a.number_of_songs > 3
GROUP BY p.publisher_name
HAVING num_alblums > 0
ORDER BY num_alblums DESC;


/* PROBLEM 2
-List right below this set of comments, the code for the Programming Problem - Multi-table Subquery
-Keep this set of comments in your team's submission
*/
-- On average, how many artists are there in one band?( only looking at bands that are "sucsessful")
SELECT 
    AVG(num_artists) AS avg_artists_per_band
FROM 
    (
        SELECT b.band_id, COUNT(a.artist_id) AS num_artists
        FROM bands b
        LEFT JOIN artists a ON b.band_id = a.band_id
        GROUP BY b.band_id
    ) AS band_artist_counts;


/* PROBLEM 3
-List right below this set of comments, the code for the Programming Problem - Updatable Single Table View
-Keep this set of comments in your team's submission
*/
-- A band has just released a new song
DROP VIEW IF EXISTS updatable_songs_view;
CREATE VIEW updatable_songs_view AS
    SELECT * FROM songs;
SELECT * FROM updatable_songs_view;
-- Insert a new record with the next primary key
INSERT INTO updatable_songs_view (song_name, date_released, alblum_id, publisher_id)
VALUES ('Summer', '2024-03-13', NULL, 4);
-- Select all records from the view
SELECT * FROM updatable_songs_view;



/* PROBLEM 4
-List right below this set of comments, the code for the Programming Problem - Stored Procedure
-Keep this set of comments in your team's submission
*/
DROP PROCEDURE IF EXISTS calculate_total_songs_by_year_sp;
-- calculate the total number of songs released in a specific year
DELIMITER $$
CREATE PROCEDURE calculate_total_songs_by_year_sp (year_param INT)
BEGIN
    DECLARE total_songs INT DEFAULT 0;
    DECLARE done INT DEFAULT 0;
    DECLARE cur_song_id INT;
    DECLARE cur_song_count INT;
    
    -- Declare cursor for songs released in the given year
    DECLARE cur_song CURSOR FOR 
        SELECT song_id
        FROM songs
        WHERE YEAR(date_released) = year_param;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur_song;

    -- Loop through the cursor to calculate the total songs in each alblum
    read_song_loop: LOOP
        FETCH cur_song INTO cur_song_id;
        IF done = 1 THEN
            LEAVE read_song_loop;
        END IF;

        -- Calculate the song count for the current alblum
        SELECT COUNT(*) INTO cur_song_count
        FROM songs
        WHERE song_id = cur_song_id;
        SET total_songs = total_songs + cur_song_count;
    END LOOP;
    CLOSE cur_song;
    SELECT CONCAT('Total songs released in ', year_param, ': ', total_songs) AS Result;

END $$
DELIMITER ;
CALL calculate_total_songs_by_year_sp(2014);

/* PROBLEM 5
-List right below this set of comments, the code for the Programming Problem - Stored Function
-Keep this set of comments in your team's submission
*/
-- Create a stored function that takes an alblum_id as input and returns the name of the band or artist for that alblum
DROP FUNCTION IF EXISTS get_band_or_artist_name_sf;
DELIMITER $$
CREATE FUNCTION get_band_or_artist_name_sf(alblum_id INT) RETURNS VARCHAR(45) DETERMINISTIC
BEGIN
    DECLARE band_or_artist_name VARCHAR(45);

    -- Check if the alblum_id exists in the alblums table
    IF EXISTS (SELECT 1 FROM alblums WHERE alblum_id = alblum_id) THEN
        -- Retrieve the band_id and artist_id for the given alblum_id
        SELECT COALESCE(bands.band_name, artists.artist_name) INTO band_or_artist_name
        FROM alblums
        LEFT JOIN bands ON alblums.band_id = bands.band_id
        LEFT JOIN artists ON alblums.artist_id = artists.artist_id
        WHERE alblums.alblum_id = alblum_id
        LIMIT 1;
        
        -- If the band_or_artist_name is empty, set it to 'Unknown'
        IF band_or_artist_name IS NULL THEN
            SET band_or_artist_name = 'Unknown';
        END IF;
    ELSE
        SET band_or_artist_name = 'Alblum not found';
    END IF;

    -- Return the band_or_artist_name
    RETURN band_or_artist_name;
END $$
DELIMITER ;
SELECT get_band_or_artist_name_sf(1); -- Should return 'Coldplay'
SELECT get_band_or_artist_name_sf(4); -- Should return 'Adele'
SELECT get_band_or_artist_name_sf(99); -- Should return 'Unkown'
