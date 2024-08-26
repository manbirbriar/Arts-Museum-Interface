DROP DATABASE IF EXISTS MUSEUM;
CREATE DATABASE MUSEUM; 
USE MUSEUM;

DROP TABLE IF EXISTS EXHIBITIONS;
CREATE TABLE EXHIBITIONS
( EName           VARCHAR(100)       NOT NULL,
  Start_date	  DATE			    NOT NULL,
  End_date	      DATE			    NOT NULL,
  PRIMARY KEY (EName));

DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST
( LName				VARCHAR(25),
  FName				VARCHAR(25),
  Dateborn			DATE,
  Datedied			DATE,
  Country_of_origin VARCHAR(25),
  Epoch_artist	    VARCHAR(20),
  Main_style 		VARCHAR(20),
  Desc_artist     	VARCHAR(200),
  PRIMARY KEY (FName, LName)); 

DROP TABLE IF EXISTS ART_OBJECTS;
CREATE TABLE ART_OBJECTS
( Id_no           INT   			NOT NULL,
  EName			  VARCHAR(100),
  Artist_f        VARCHAR(20),
  Artist_l		  VARCHAR(20),
  Year_made       INT,
  Title           VARCHAR(100)      NOT NULL,
  Desc_art     	  VARCHAR(10000)	NOT NULL,
  Category 		  VARCHAR(20)		NOT NULL,
  Origin		  VARCHAR(20),
  Epoch_art		  VARCHAR(20),
  PRIMARY KEY (Id_no),
  FOREIGN KEY(Artist_f, Artist_l) REFERENCES ARTIST(FName, LName),
  FOREIGN KEY(EName) REFERENCES EXHIBITIONS(EName));

DROP TABLE IF EXISTS PAINTING;
CREATE TABLE PAINTING
( Id_no           INT   			NOT NULL,
  Paint_type      VARCHAR(15)       NOT NULL,
  Drawn_on        VARCHAR(15)       NOT NULL,
  Style       	  VARCHAR(25)		NOT NULL,
  PRIMARY KEY (Id_no),
  FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no));

DROP TABLE IF EXISTS SCULPTURE_STATUE;
CREATE TABLE SCULPTURE_STATUE
( Id_no           INT   			NOT NULL,
  Material        VARCHAR(15)       NOT NULL,
  Height          INT       		NOT NULL,
  Weight		  INT				NOT NULL,
  Style       	  VARCHAR(25)		NOT NULL,
  PRIMARY KEY (Id_no),
  FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no));

DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER
( Id_no           INT   			NOT NULL,
  Type_of		  VARCHAR(15)		NOT NULL,
  Style       	  VARCHAR(25)		NOT NULL,
  PRIMARY KEY (Id_no),
  FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no));

DROP TABLE IF EXISTS PERMANENT_COLLECTION;
CREATE TABLE PERMANENT_COLLECTION
( Id_no           INT   			NOT NULL,
  Date_aquired 	  DATE,
  Status_of       VARCHAR(10),
  Cost            INT				NOT NULL,
  PRIMARY KEY (Id_no),
  FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no));

DROP TABLE IF EXISTS COLLECTIONS;
CREATE TABLE COLLECTIONS
( CName           VARCHAR(30)       NOT NULL,
  Type_collector  VARCHAR(15)		NOT NULL,
  Desc_collector  VARCHAR(25),
  Address		  VARCHAR(40),
  Phone			  CHAR(12),
  Contact		  VARCHAR(20) 		NOT NULL,
  PRIMARY KEY (CName));

DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED
( Id_no           INT   			NOT NULL,
  Collection 	  VARCHAR(30),
  Date_borrowed   DATE,
  Date_returned	  DATE,
  PRIMARY KEY (Id_no),
  FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no),
  FOREIGN KEY (Collection) REFERENCES COLLECTIONS(CName));

INSERT INTO EXHIBITIONS (EName, Start_date, End_date)
VALUES
('Northern Renaissance Stained Glass: Continuity and Transformations', '1987-02-02', '1987-03-08'),
('The Tudors: Art and Majesty in Renaissance England', '2023-02-01', '2023-05-14'),
('The Eastern 17th Century Display of the Arts', '1402-03-20', '2069-03-20'),
('The French Historical Display', '2006-01-31', '2023-01-30');

INSERT INTO ARTIST (LName, FName, Dateborn, Datedied, Country_of_origin, Epoch_artist, Main_style, Desc_artist)
VALUES
('Vellert', 'Dirck', '1480-02-01', '1547-03-15', 'Netherlands', 'Renaissance', 'Stained Glass', 'Dirck Vellert was a Flemish Renaissance painter.'),
('Christus', 'Petrus', '1444-07-06', '1475-03-20', 'Netherlands', 'Renaissance', 'Oil Painting', 'Petrus Christus was an Early Netherlandish painter active in Bruges from 1444.'),
('Fernandez', 'Juan', NULL, NULL, 'Spain', '17th Century', 'Oil Painting', 'Juan Fernández, nicknamed El Labrador, was a Spanish Baroque painter active between 1629 and 1636.'),
('Torrigiano', 'Pietro', '1472-11-24', '1528-08-01', 'Italy', 'Renaissance', 'Sculpture', "Italian Renaissance sculptor from Florence, who had to flee the city after breaking Michelangelo's nose."),
('Holbein', 'Hans', '1497-01-01', '1543-01-01', 'Germany', 'Renaissance', 'Portraiture', "German painter, draftsman, and designer, renowned for the precise rendering and realism of his art." ),
('Partridge', 'Affabel', NULL, NULL, 'England', 'Elizabethan', 'Goldsmithing', "Affabel Partridge was a London goldsmith who served Elizabeth I. He is thought to have marked his work with a hallmark of a bird."),
('Tut', 'King', '1632-04-30', '1684-02-28', 'Egypt', 'Ancient Egypt', 'Statues', "Tutankhamun, also known as Tutankhaten, was the antepenultimate pharaoh of the Eighteenth Dynasty of ancient Egypt."),
('Dynamite', 'Napoleon', '1928-07-23', '1974-02-28', 'United Kingdom', '19th Century', 'Paintings', "Napoleon Dynamite was born in 1928 to parents Gertrude and Johnathon, and quickly rose to fame due ot his initial outgoing art.");

INSERT INTO ART_OBJECTS (Id_no, EName, Artist_f, Artist_l, Year_made, Title, Desc_art, Category, Origin, Epoch_art)
VALUES
('001', 'Northern Renaissance Stained Glass: Continuity and Transformations', 'Dirck', 'Vellert', 1530, 
'Martyrdom of the Seven Maccabee Brothers and Their Mother', 'The Old Testament tells the horrific story of King Antiochus IV Epiphanes murdering a Jewish family for their refusal to eat pork, a narrative of religious persecution that would have resonated with many groups in sixteenth-century Northern Europe.', 'Other', 'European', 'Flemish'),

('002', 'The Tudors: Art and Majesty in Renaissance England', 'Petrus', 'Christus', 1450, 'The Lamentation', 'Intended for private devotion, this painting depicts the lamentation over Christ’s dead body as a model for the viewer’s own contemplation and empathy. The figures lifting Christ’s shroud, Joseph of Arimathea and Nicodemus, stand out in their contemporary attire, offering a bridge to the artist’s own time.', 'Painting', 'European', 'Netherlandish'),

('003', 'The Eastern 17th Century Display of the Arts', 'Juan', 'Fernandez', 1636, 'Still Life with Four Bunches of Grapes', 'Pliny the Elder’s origin story of eye-deceiving illusionism and creative competition, recounted on the wall at right, influenced artists in the Renaissance and for centuries after.', 'Painting', 'Italian', 'Spanish'),

('004', 'The Tudors: Art and Majesty in Renaissance England', 'Pietro', 'Torrigiano', 1510, 'Portrait Bust of John Fisher, Bishop of Rochester', "The subject was traditionally identified as John Fisher, Bishop of Rochester and confessor to Henry VIII's first queen, Catherine of Aragon, but the identification has been increasingly called into question.", 'Sculpture/Statue', 'Italy', 'Renaissance'),

('005', 'The Tudors: Art and Majesty in Renaissance England', 'Hans', 'Holbein', 1527, 'Armor Garniture, Probably of King Henry VIII of England',  "This is the earliest dated armor from the royal workshops at Greenwich, which were established in 1515 by Henry VIII (reigned 1509–47) to produce armors for himself and his court. It is also the earliest surviving Greenwich garniture, an armor made with a series of exchange and reinforcing pieces by which it could be adapted for use in battle and in different forms of the tournament. Furthermore, the overall etching and gilding place it among the most richly decorated of all Greenwich armors. ", 'Sculpture/Statue', 'British', 'Renaissance'),

('006', 'The Tudors: Art and Majesty in Renaissance England', 'Affabel', 'Partridge', 1570, 'Cup and Cover', "The red-glazed ground of this cup was originally decorated with a finely-drawn gold decoration which has now largely worn off. This style of painting in gold on a colored ground was produced in China primarily for the Japanese market, where it was termed kinrande ('gold brocaded.') Queen Elizabeth I was presented with a similar mounted cup in 1582.", 'Other', 'British', 'Elizabethan'),

('007', 'The Tudors: Art and Majesty in Renaissance England', NULL, NULL, 1600, 'Bearing Cloth', "Needlework from England was prized throughout Europe, and was one medium for which the Tudors felt no need to import talent. This magnificent satin embellished with a broad border of elaborate, ornamental embroidery was almost certainly a bearing cloth- used to wrap and carry an infant during baptisms and other ceremonial occasions- from a particularly wealthy, possibly noble or even royal, household.", 'Other', 'British', 'Renaissance'),
    
('008', 'The Eastern 17th Century Display of the Arts', 'King', 'Tut', 1649, 'serviteur funéraire momiforme', "The 'serviteur funéraire momiforme' is a mesmerizing art piece that transports viewers to a bygone era, specifically 1649, with its rich historical and cultural references.", 'Sculpture/Statue', 'Egyptian', 'Ancient Egypt'),
    
('009', 'The Tudors: Art and Majesty in Renaissance England', 'Pietro', 'Torrigiano', 1400, "Pietro D'Abano", "In 1631, following the death of the last Duke of Urbino, the paintings were transferred to Rome under the ownership of Pope Urban VIII. In 1632, the pope gave the paintings to his nephew, Cardinal-Legate Antonio Barberini.", 'Painting', 'Italian', 'Renaissance'),
    
('010', 'The Eastern 17th Century Display of the Arts', 'King', 'Tut', 1550, "chevet à tronc octogonal", "Carved from the enduring embrace of stone, this magnificent sculpture unveils the stoic visage of an Egyptian man, frozen in timeless repose. ", 'Other', 'Egyptian', 'Ancient Egypt'),

('011', 'The Eastern 17th Century Display of the Arts', 'King', 'Tut', 1638, "tête de massue piriforme", "The pot's form is both elegant and functional, with a smooth and rounded silhouette that suggests the hands of a skilled artisan at work. The interplay of the darker and lighter tones on its surface adds a subtle depth, creating an aesthetic that is both earthy and refined.", 'Sculpture/Statue', 'Egyptian', 'Ancient Egypt'),
 
 ('012', 'The French Historical Display', 'Napoleon', 'Dynamite', 1946, "Gravure du Roi de Rome.", "Upon the canvas of an official parchment, the embodiment of innocence is captured in the form of a cherubic baby. ", 'Painting', 'French', 'French Revolution');

INSERT INTO PAINTING (Id_no, Paint_type, Drawn_on, Style)
VALUES
('002', 'Oil', 'Wood', 'Mannerist'),
('003', 'Oil', 'Canvas', 'Still Life'),
('009', 'Chalk', 'Canvas', 'Portrait'),
('012', 'Charcoal', 'Paper', 'Portrait');

INSERT INTO SCULPTURE_STATUE (Id_no, Material, Height, Weight, Style)
VALUES
('004', 'Terracotta', '65.7', '28.1', 'Bust'),
('005', 'Metal', '185.4', '28.5', 'Armour'),
('008', 'Clay', '8.3', '2.5', 'Little Man'),
('011', 'Stone', '20.5', '28.4', 'Pot');

INSERT INTO OTHER (Id_no, Type_of, Style)
VALUES
('001', 'Stained Glass', 'Gothic'),
('006', 'Ceramic', 'China'),
('007', 'Drapery', 'Religious'),
('010', 'Furniture', 'Greek');

INSERT INTO PERMANENT_COLLECTION (id_no, Date_aquired, Status_of, Cost)
VALUES
('001', '1987-02-02', "On Display", 500000),
('002', '1973-05-18', "On Display", 700000),
('003', '2022-10-17', "Stored", 400000),
('010', '1942-03-19', "On Display", 900000),
('011', '1856-09-14', "Stored", 500000),
('012', '1947-09-14', "Stored", 1000000);

INSERT INTO COLLECTIONS (CName, Type_collector, Desc_collector, Address, Phone, Contact)
VALUES
('Keith Shadis Collection', 'Museum', "Busts and Statues", 
	'108 Misery Road, Calgary, Alberta', '403-998-2321', 'Sasha Blouse'),
 ('Erwin Smith Collection', 'Personal', 'Armours', 
	'281 Enemy Lane, Toronto, Ontario', '381-228-2091', 'Levi Ackerman'),
('Hange Zoe Collection', 'Museum', "Cups and Jewelry", 
	'111 Titan Ave, Victoria, Brtish Columbia', '281-331-2619', 'Moblit Berner'),
('Armin Arlet Collection', 'Personal', "Drapery and Fabrics",
	'319 Burden Street, Edmonton, Alberta', '587-619-0420', 'Mikasa Ackerman'),
('Musee Guimet', 'Museum', "Statues and Old Stones", 
	'222 Arrow Street, Moon, Space', '403-935-1122', 'Sam Johnson');
    
INSERT INTO BORROWED (id_no, Collection, Date_borrowed, Date_returned)
VALUES
('004', 'Keith Shadis Collection', '1987-02-02', '2024-11-25'),
('005', 'Erwin Smith Collection', '1973-05-18', '2024-11-26'),
('006', 'Hange Zoe Collection', '2022-10-17', '2024-11-27'),
('007', 'Armin Arlet Collection', '2022-10-17', '2024-11-28'),
('008', 'Musee Guimet', '1948-08-05', NULL),
('009', 'Musee Guimet', '1862-04-21', NULL);
  
  