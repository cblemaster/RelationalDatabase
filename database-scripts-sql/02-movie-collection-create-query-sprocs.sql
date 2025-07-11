
USE MovieCollection
GO

CREATE VIEW Movies.ActorsWithMovies
AS
   SELECT a.[Name] AS ActorName, STRING_AGG(m.Title, ', ') AS Movies, a.Id AS ActorId
   FROM Movies.Actor a
   LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
   INNER JOIN Movies.Movie m ON (ma.MovieId = m.Id)
   GROUP BY a.[Name], a.Id;
GO

CREATE VIEW Movies.MoviesWithActors
AS
   SELECT m.Title, STRING_AGG(a.[Name], ', ') AS Actors, m.Id AS MovieId
   FROM Movies.Movie m
   LEFT JOIN Movies.MovieActor ma ON (m.Id = ma.MovieId)
   INNER JOIN Movies.Actor a ON (ma.ActorId = a.Id)
   GROUP BY m.Title, m.Id;
GO

CREATE PROCEDURE Movies.MoviesWithDetails
AS
   SET NOCOUNT ON;
   SELECT m.Id, m.Title, m.DirectorName, m.ReleaseYear, m.RunTimeMinutes, m.StarRating, m.DateAcquired,
        g.[Description] AS GenreDescription, r.[Description] AS RatingDescription,
        (SELECT IIF(r.IsKidFriendly = 0,'No','Yes')) AS RatingIsKidFriendly,
        (SELECT ma.Actors FROM Movies.MoviesWithActors ma WHERE ma.MovieId = m.Id) AS Actors
   FROM Movies.Movie m
   INNER JOIN Movies.Genre g ON (m.GenreId = g.Id)
   INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
   ORDER BY m.Title;
GO

CREATE PROCEDURE Movies.CountOfMoviesByGenre
AS
   SET NOCOUNT ON;
   SELECT g.[Description] AS GenreDescription, COUNT(m.Id) AS CountOfMovies
   FROM Movies.Genre g
   LEFT JOIN Movies.Movie m ON (g.Id = m.GenreId)
   GROUP BY g.[Description]
   ORDER BY CountOfMovies DESC, GenreDescription;
GO

CREATE PROCEDURE Movies.CountOfMoviesByRating
AS
   SET NOCOUNT ON;
   SELECT r.[Description] AS RatingDescription, COUNT(m.Id) AS CountOfMovies
   FROM Movies.Rating r
   LEFT JOIN Movies.Movie m ON (r.Id = m.RatingId)
   GROUP BY r.[Description]
   ORDER BY CountOfMovies DESC, RatingDescription;
GO

CREATE PROCEDURE Movies.CountOfMoviesByDirector
AS
   SET NOCOUNT ON;
   SELECT m.DirectorName, COUNT(m.Id) AS CountOfMovies
   FROM Movies.Movie m
   GROUP BY m.DirectorName
   ORDER BY CountOfMovies DESC, m.DirectorName;
GO

CREATE PROCEDURE Movies.CountOfMoviesByReleaseYear
AS
   SET NOCOUNT ON;
   SELECT m.ReleaseYear, COUNT(m.Id) AS CountOfMovies
   FROM Movies.Movie m
   GROUP BY m.ReleaseYear
   ORDER BY CountOfMovies DESC, m.ReleaseYear;
GO

CREATE PROCEDURE Movies.CountOfMoviesByStarRating
AS
   SET NOCOUNT ON;
   SELECT m.StarRating, COUNT(m.Id) AS CountOfMovies
   FROM Movies.Movie m
   GROUP BY m.StarRating
   ORDER BY CountOfMovies DESC, m.StarRating;
GO

CREATE PROCEDURE Movies.CountOfMoviesByActor
AS
   SET NOCOUNT ON;
   SELECT a.[Name] AS ActorName, COUNT(m.Id) AS CountOfMovies
   FROM Movies.Actor a
   LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
   LEFT JOIN Movies.Movie m ON (ma.MovieId = m.Id)
   GROUP BY a.[Name]
   ORDER BY CountOfMovies DESC, ActorName;
GO

CREATE PROCEDURE Movies.TotalRunTimeByDirector
AS
   SET NOCOUNT ON;
   SELECT m.DirectorName, SUM(m.RunTimeMinutes) AS TotalRunTimeMinutes
   FROM Movies.Movie m
   GROUP BY m.DirectorName
   ORDER BY TotalRunTimeMinutes DESC, m.DirectorName;
GO

CREATE PROCEDURE Movies.TotalRunTimeByReleaseYear
AS
   SET NOCOUNT ON;
   SELECT m.ReleaseYear, SUM(m.RunTimeMinutes) AS TotalRunTimeMinutes
   FROM Movies.Movie m
   GROUP BY m.ReleaseYear
   ORDER BY TotalRunTimeMinutes DESC, m.ReleaseYear;
GO

CREATE PROCEDURE Movies.TotalRunTimeByGenre
AS
   SET NOCOUNT ON;
   SELECT g.[Description] AS GenreDescription, SUM(m.RunTimeMinutes) AS TotalRunTimeMinutes
   FROM Movies.Genre g
   LEFT JOIN Movies.Movie m ON (g.Id = m.GenreId)
   GROUP BY g.[Description]
   ORDER BY TotalRunTimeMinutes DESC, GenreDescription;
GO

CREATE PROCEDURE Movies.TotalRunTimeByRating
AS
   SET NOCOUNT ON;
   SELECT r.[Description] AS RatingDescription, SUM(m.RunTimeMinutes) AS TotalRunTimeMinutes
   FROM Movies.Rating r
   LEFT JOIN Movies.Movie m ON (r.Id = m.RatingId)
   GROUP BY r.[Description]
   ORDER BY TotalRunTimeMinutes DESC, RatingDescription;
GO

CREATE PROCEDURE Movies.TotalRunTimeByActor
AS
   SET NOCOUNT ON;
   SELECT a.[Name] AS ActorName, SUM(m.RunTimeMinutes) AS TotalRunTimeMinutes
   FROM Movies.Actor a
   LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
   LEFT JOIN Movies.Movie m ON (ma.MovieId = m.Id)
   GROUP BY a.[Name]
   ORDER BY TotalRunTimeMinutes DESC, ActorName;
GO

CREATE PROCEDURE Movies.GenresWithMoviesHavingRatingIsKidFriendly
AS
   SET NOCOUNT ON;
   SELECT g.[Description] AS GenreDescription
   FROM Movies.Genre g
   LEFT JOIN Movies.Movie m ON (g.Id = m.GenreId)
   INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
   WHERE r.IsKidFriendly = 1
   GROUP BY g.[Description]
   ORDER BY g.[Description];
GO

CREATE PROCEDURE Movies.DirectorsWithMoviesHavingRatingIsKidFriendly
AS
   SET NOCOUNT ON;
   SELECT m.DirectorName
   FROM Movies.Movie m
   INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
   WHERE r.IsKidFriendly = 1
   GROUP BY m.DirectorName
   ORDER BY m.DirectorName;
GO

CREATE PROCEDURE Movies.ActorsWithMoviesHavingRatingIsKidFriendly
AS
   SET NOCOUNT ON;
   SELECT a.[Name] AS ActorName
   FROM Movies.Actor a
   LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
   LEFT JOIN Movies.Movie m ON (ma.MovieId = m.Id)
   INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
   WHERE r.IsKidFriendly = 1
   GROUP BY a.[Name]
   ORDER BY a.[Name];
GO
