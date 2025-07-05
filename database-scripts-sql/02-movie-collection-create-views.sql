
USE MovieCollection
GO

CREATE VIEW Movies.ActorsWithMovies AS
    SELECT a.[Name] AS ActorName, STRING_AGG(m.Title, ', ') AS "Movies", a.Id AS "ActorId"
    FROM Movies.Actor a
    LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
    INNER JOIN Movies.Movie m ON (ma.MovieId = m.Id)
    GROUP BY a.[Name], a.Id;
GO

CREATE VIEW Movies.MoviesWithActors AS
    SELECT m.Title AS MovieTitle, STRING_AGG(a.[Name], ', ') AS "Actors", m.Id AS "MovieId"
    FROM Movies.Movie m
    LEFT JOIN Movies.MovieActor ma ON (m.Id = ma.MovieId)
    INNER JOIN Movies.Actor a ON (ma.ActorId = a.Id)
    GROUP BY m.Title, m.Id;
GO

CREATE VIEW Movies.MoviesAlphabeticalByTitle AS
    SELECT m.Id, M.Title, m.DirectorName, m.ReleaseYear, m.RunTimeMinutes, m.StarRating, m.DateAcquired,
        g.[Description] AS GenreDescription, r.[Description] AS RatingDescription,
        (SELECT IIF(r.IsKidFriendly = 0,'No','Yes')) AS RatingIsKidFriendly,
        (SELECT ma.Actors FROM Movies.MoviesWithActors ma WHERE ma.MovieId = m.Id) AS Actors
    FROM Movies.Movie m
    INNER JOIN Movies.Genre g ON (m.GenreId = g.Id)
    INNER JOIN Movies.Rating r ON (m.RatingId = r.Id);
GO

CREATE VIEW Movies.CountOfMoviesByGenre AS
    SELECT g.[Description] AS GenreDescription, COUNT(m.Id) AS CountOfMovies
    FROM Movies.Genre g
    LEFT JOIN Movies.Movie m ON (g.Id = m.GenreId)
    GROUP BY g.[Description];
GO

CREATE VIEW Movies.CountOfMoviesByRating AS
    SELECT r.[Description] AS RatingDescription, COUNT(m.Id) AS CountOfMovies
    FROM Movies.Rating r
    LEFT JOIN Movies.Movie m ON (r.Id = m.RatingId)
    GROUP BY r.[Description];
GO

CREATE VIEW Movies.CountOfMoviesByDirector AS
    SELECT m.DirectorName, COUNT(m.Id) AS CountOfMovies
    FROM Movies.Movie m
    GROUP BY m.DirectorName;
GO

CREATE VIEW Movies.CountOfMoviesByReleaseYear AS
    SELECT m.ReleaseYear, COUNT(m.Id) AS CountOfMovies
    FROM Movies.Movie m
    GROUP BY m.ReleaseYear;
GO

CREATE VIEW Movies.CountOfMoviesByStarRating AS
    SELECT m.StarRating AS StarRating, COUNT(m.Id) AS CountOfMovies
    FROM Movies.Movie m
    GROUP BY m.StarRating;
GO

CREATE VIEW Movies.CountOfMoviesByActor AS
    SELECT a.[Name] AS ActorName, COUNT(m.Id) AS CountOfMovies
    FROM Movies.Actor a
    LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
    INNER JOIN Movies.Movie m ON (ma.MovieId = m.Id)
    GROUP BY a.[Name];
GO

CREATE VIEW Movies.FiveLongestByRunTime AS
    SELECT TOP 5 m.Title, m.RunTimeMinutes
    FROM Movies.Movie m;
GO

CREATE VIEW Movies.FiveShortestByRunTime AS
    SELECT TOP 5 m.Title, m.RunTimeMinutes
    FROM Movies.Movie m;
GO

CREATE VIEW Movies.TotalRunTimByDirector AS
    SELECT m.DirectorName, SUM(m.RunTimeMinutes) AS TotalRunTimMinutes
    FROM Movies.Movie m
    GROUP BY m.DirectorName;
GO

CREATE VIEW Movies.TotalRunTimByReleaseYear AS
    SELECT m.ReleaseYear, SUM(m.RunTimeMinutes) AS TotalRunTimMinutes
    FROM Movies.Movie m
    GROUP BY m.ReleaseYear;
GO

CREATE VIEW Movies.TotalRunTimByGenre AS
    SELECT g.[Description] AS GenreDescription, SUM(m.RunTimeMinutes) AS TotalRunTimMinutes
    FROM Movies.Genre g
    LEFT JOIN Movies.Movie m ON (g.Id = m.GenreId)
    GROUP BY g.[Description];
GO

CREATE VIEW Movies.TotalRunTimByRating AS
    SELECT r.[Description] AS RatingDescription, SUM(m.RunTimeMinutes) AS TotalRunTimMinutes
    FROM Movies.Rating r
    LEFT JOIN Movies.Movie m ON (r.Id = m.RatingId)
    GROUP BY r.[Description];
GO

CREATE VIEW Movies.TotalRunTimByActor AS
    SELECT a.[Name] AS ActorName, SUM(m.RunTimeMinutes) AS TotalRunTimMinutes
    FROM Movies.Actor a
    LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
    INNER JOIN Movies.Movie m ON (ma.MovieId = m.Id)
    GROUP BY a.[Name];
GO

CREATE VIEW Movies.GenresWithMoviesHavingRatingIsKidFriendly AS
    SELECT g.[Description] AS GenreDescription
    FROM Movies.Genre g
    LEFT JOIN Movies.Movie m ON (g.Id = m.GenreId)
    INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
    WHERE r.IsKidFriendly = 1
    GROUP BY g.[Description];
GO

CREATE VIEW Movies.DirectorsWithMoviesHavingRatingIsKidFriendly AS
    SELECT m.DirectorName
    FROM Movies.Movie m
    INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
    WHERE r.IsKidFriendly = 1
    GROUP BY m.DirectorName;
GO

CREATE VIEW Movies.ActorsWithMoviesHavingRatingIsKidFriendly AS
    SELECT a.[Name] AS ActorName
    FROM Movies.Actor a
    LEFT JOIN Movies.MovieActor ma ON (a.Id = ma.ActorId)
    INNER JOIN Movies.Movie m ON (ma.MovieId = m.Id)
    INNER JOIN Movies.Rating r ON (m.RatingId = r.Id)
    WHERE r.IsKidFriendly = 1
    GROUP BY a.[Name];
GO
