
USE MovieCollection
GO

-- required genre data
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Action');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Adventure');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Animated adults');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Animated kids');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Comedy');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Documentary');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Drama');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Family Comedy');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Fantasy');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Historical');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Horror');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Kids');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Mystery');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Romance');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Science Fiction');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Thriller');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Young Adult');
INSERT INTO Movies.Genre(Id,[Description]) VALUES(NEWID(),'Other');

-- required rating data
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'G',1);
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'PG',1);
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'PG-13',1);
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'R',0);
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'NC-17',0);
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'X',0);
INSERT INTO Movies.Rating(Id,[Description],IsKidFriendly) VALUES(NEWID(),'Unrated',0);
