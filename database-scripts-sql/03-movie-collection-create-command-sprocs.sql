
USE MovieCollection
GO

CREATE PROCEDURE Movies.CreateActor
   @Name VARCHAR(255),
   @IsDeceased BIT
AS
   SET NOCOUNT ON;
   INSERT INTO Movies.Actor(Id,[Name],IsDeceased) VALUES(NEWID(),@Name,@IsDeceased);
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.UpdateActor
   @Id UNIQUEIDENTIFIER,
   @Name VARCHAR(255),
   @IsDeceased BIT
AS
   SET NOCOUNT ON;
   UPDATE Movies.Actor
   SET [Name] = @Name, IsDeceased = @IsDeceased
   WHERE Movies.Actor.Id = @Id;
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.CreateMovie
   @Title VARCHAR(255),
   @DirectorName VARCHAR(255),
   @ReleaseYear INT,
   @RunTimeMinutes INT,
   @StarRating INT NULL,
   @DateAcquired DATE NULL,
   @GenreId UNIQUEIDENTIFIER,
   @RatingId UNIQUEIDENTIFIER
AS
   SET NOCOUNT ON;
   INSERT INTO Movies.Movie(Id,Title,DirectorName,ReleaseYear,RunTimeMinutes,StarRating,
		DateAcquired,GenreId,RatingId)
		VALUES(NEWID(),@Title,@DirectorName,@ReleaseYear,@RunTimeMinutes,@StarRating,
			@DateAcquired,@GenreId,@RatingId);
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.UpdateMovie
   @Id UNIQUEIDENTIFIER,
   @Title VARCHAR(255),
   @DirectorName VARCHAR(255),
   @ReleaseYear INT,
   @RunTimeMinutes INT,
   @StarRating INT NULL,
   @DateAcquired DATE NULL,
   @GenreId UNIQUEIDENTIFIER,
   @RatingId UNIQUEIDENTIFIER
AS
   SET NOCOUNT ON;
   UPDATE Movies.Movie
   SET Title = @Title, DirectorName = @DirectorName, ReleaseYear = @ReleaseYear, 
		RunTimeMinutes = @RunTimeMinutes, StarRating = @StarRating, 
		DateAcquired = @DateAcquired, GenreId = @GenreId, RatingId = @RatingId
   WHERE Movies.Movie.Id = @Id;
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.AddMovieToActor
   @ActorId UNIQUEIDENTIFIER,
   @MovieId UNIQUEIDENTIFIER
AS
   SET NOCOUNT ON;
   INSERT INTO Movies.MovieActor(ActorId,MovieId) VALUES(@ActorId,@MovieId);
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.RemoveMovieFromActor
   @ActorId UNIQUEIDENTIFIER,
   @MovieId UNIQUEIDENTIFIER
AS
   SET NOCOUNT ON;
   DELETE ma
   FROM Movies.MovieActor ma
   WHERE ma.ActorId = @ActorId AND ma.MovieId = @MovieId;
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.DeleteActor
   @ActorId UNIQUEIDENTIFIER
AS
   SET NOCOUNT ON;
   DELETE ma
   FROM Movies.MovieActor ma
   WHERE ma.ActorId = @ActorId;
   DELETE a
   FROM Movies.Actor a
   WHERE a.Id = @ActorId;
   SELECT @@ROWCOUNT;
GO

CREATE PROCEDURE Movies.DeleteMovie
   @MovieId UNIQUEIDENTIFIER
AS
   SET NOCOUNT ON;
   DELETE ma
   FROM Movies.MovieActor ma
   WHERE ma.MovieId = @MovieId;
   DELETE m
   FROM Movies.Movie m
   WHERE m.Id = @MovieId;
   SELECT @@ROWCOUNT;
GO
