-- 1
-- Show all tables in the database
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'MUSEUM';          

-- Show the columns and their data types for each table
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'MUSEUM';

-- Show foreign keys for each table
SELECT
    table_name        
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.key_column_usage
WHERE table_schema = 'MUSEUM'
AND referenced_table_name IS NOT NULL;

-- 1 
SHOW TABLES;
DESCRIBE ART_OBJECTS;
DESCRIBE PAINTING;
DESCRIBE PERMANENT_COLLECTION;
DESCRIBE SCULPTURE_STATUE;
DESCRIBE OTHER;
DESCRIBE ARTIST;
DESCRIBE BORROWED;
DESCRIBE COLLECTIONS;
DESCRIBE EXHIBITIONS;



-- 2
SELECT * FROM EXHIBITIONS;

-- 3
SELECT * FROM ARTIST ORDER BY Dateborn;


-- 4
SELECT EName, Start_date, End_date
FROM EXHIBITIONS
WHERE Start_date IN (SELECT MAX(Start_date) FROM EXHIBITIONS);


-- 5
SELECT ARTIST.LName, ART_OBJECTS.Title
FROM ARTIST
INNER JOIN ART_OBJECTS ON ARTIST.FName = ART_OBJECTS.Artist_f AND ARTIST.LName = ART_OBJECTS.Artist_l;


-- 6 
SET sql_safe_updates = 0;
UPDATE COLLECTIONS
SET Type_collector = 'Personal'
WHERE CName = 'Hange Zoe Collection';

SELECT * FROM COLLECTIONS WHERE CName = 'Hange Zoe Collection';

SET sql_safe_updates = 1;


-- 7
DELETE FROM BORROWED WHERE id_no = '004';


