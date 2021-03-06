USE [master]
GO
/****** Object:  Database [Scrabble]    Script Date: 08/29/2014 17:03:46 ******/
CREATE DATABASE [Scrabble] ON  PRIMARY 
( NAME = N'Scrabble', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Scrabble.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Scrabble_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Scrabble_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Scrabble] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Scrabble].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Scrabble] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Scrabble] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Scrabble] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Scrabble] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Scrabble] SET ARITHABORT OFF
GO
ALTER DATABASE [Scrabble] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Scrabble] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Scrabble] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Scrabble] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Scrabble] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Scrabble] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Scrabble] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Scrabble] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Scrabble] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Scrabble] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Scrabble] SET  DISABLE_BROKER
GO
ALTER DATABASE [Scrabble] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Scrabble] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Scrabble] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Scrabble] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Scrabble] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Scrabble] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Scrabble] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Scrabble] SET  READ_WRITE
GO
ALTER DATABASE [Scrabble] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Scrabble] SET  MULTI_USER
GO
ALTER DATABASE [Scrabble] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Scrabble] SET DB_CHAINING OFF
GO
USE [Scrabble]
GO
/****** Object:  User [tavisca]    Script Date: 08/29/2014 17:03:46 ******/
CREATE USER [tavisca] FOR LOGIN [tavisca] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [pramod]    Script Date: 08/29/2014 17:03:46 ******/
CREATE USER [pramod] FOR LOGIN [team1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tbl_board_m]    Script Date: 08/29/2014 17:03:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_board_m](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tile_type] [nchar](2) NOT NULL,
 CONSTRAINT [PK_tbl_board_M] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[update_tray]    Script Date: 08/29/2014 17:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[update_tray]
--(
--@game_id int,
--@player_id int 
--)
AS
BEGIN
	Declare @game_id int
	Declare @no_of_chars_used int
	Declare @player_id int
	DECLARE @Tray varchar(20)
	DECLARE @Temp_Tray nchar(7)
	DECLARE @LetterIndex int
	declare @character char
	
	set @game_id=1
	set @player_id=1
	set @Tray='aa-bcc-'
	--select @Tray=tray_content from tbl_player_tray where game_id=@game_id and player_id=@player_id
	set @Temp_Tray=@Tray
	set @Tray=REPLACE(@Tray,'-','')
	set @no_of_chars_used=len(@Temp_Tray)-len(@Tray)
	while(@no_of_chars_used > 0)
	begin
		set @character = (select char(rand()*26+97));
		              
		set @Tray = @Tray + @character
		--exec osp_UpdateLetterBag @game_id = @game_id,@character = @character
		set @no_of_chars_used = @no_of_chars_used - 1;
	end	
	
	--print @no_of_chars_used
	--print len(@Tray)
	print @Tray								
										
END
GO
/****** Object:  Table [dbo].[tbl_tile_type_m]    Script Date: 08/29/2014 17:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tile_type_m](
	[Name] [nchar](2) NOT NULL,
	[Points] [int] NOT NULL,
 CONSTRAINT [PK_tbl_tile_type_M] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_player]    Script Date: 08/29/2014 17:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_player](
	[player_id] [int] NOT NULL,
	[player_name] [nchar](20) NOT NULL,
 CONSTRAINT [PK_tbl_player] PRIMARY KEY CLUSTERED 
(
	[player_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_letter_bag_m]    Script Date: 08/29/2014 17:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_letter_bag_m](
	[letter] [char](1) NOT NULL,
	[max_count] [int] NULL,
	[points] [int] NULL,
 CONSTRAINT [PK_tbl_letter_bag_m] PRIMARY KEY CLUSTERED 
(
	[letter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_board_tile_occupied]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_board_tile_occupied]
(
	@board nchar(255),@index_of_letter_at_top int
)
RETURNS int
AS
BEGIN
		Declare @letter char
		
		set @letter = substring(@board,@index_of_letter_at_top,1)
		
		if(@letter != '*')
		begin 
			return 1
		end
		
		return 0
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_get_letter_id_by_position]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_get_letter_id_by_position]
 (@row int, @col int)
RETURNS int
AS
BEGIN
	DECLARE @letter_index int
	set @letter_index  = (@row-1) * 15 + @col
	RETURN @letter_index
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_help]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ssp_help]
AS
BEGIN
print  '----------------------------------------------------------------'
	print  '| Use *exec ssp_show_open_games* to get list of open games |'
	print  '| Use player id to create and join a game |'
		print  '| Use *exec ssp_create_game player_id* to start a new game |'
		print  '| Use *exec osp_JoinGame game id player_id* to join an existing game |'
print  '----------------------------------------------------------------'
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_get_player_id]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ssp_get_player_id]
(
	-- Add the parameters for the stored procedure here
	@name nchar(30)
)
AS
BEGIN
declare @id int
    -- Insert statements for procedure here
    select @id=player_id from tbl_player where player_name=@name
return @id
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_player_details]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ssp_player_details]
	AS
BEGIN

DECLARE @player_id int
DECLARE @player_name varchar(20)

DECLARE players CURSOR
STATIC FOR 
SELECT  player_id ,player_name from tbl_player
	OPEN players
		IF @@CURSOR_ROWS > 0
		BEGIN 
			FETCH NEXT FROM players INTO @player_id,@player_name
			WHILE @@Fetch_status = 0
			BEGIN
				PRINT 'Player: '+ @player_name + 'Player Id: ' +  convert(varchar(10),@player_id) +''
				FETCH NEXT FROM players INTO @player_id,@player_name
			END
		END
CLOSE players
DEALLOCATE players
	execute ssp_help
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_valid_player]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_valid_player]
( @player_id int)

RETURNS int
AS
BEGIN

	DECLARE @valid_flag int
	set @valid_flag = (select COUNT(player.player_id) from Scrabble.dbo.tbl_player as player where player.player_id= @player_id)
	RETURN @valid_flag

END
GO
/****** Object:  Table [dbo].[tbl_game_room]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_game_room](
	[game_id] [int] IDENTITY(1,1) NOT NULL,
	[game_status] [nchar](10) NOT NULL,
	[first_player_id] [int] NOT NULL,
	[second_player_id] [int] NULL,
	[first_player_score] [int] NULL,
	[second_player_score] [int] NULL,
 CONSTRAINT [PK_tbl_game_room] PRIMARY KEY CLUSTERED 
(
	[game_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_game_letter_bag]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_game_letter_bag](
	[game_id] [int] NOT NULL,
	[letter] [char](1) NOT NULL,
	[letter_count] [int] NULL,
 CONSTRAINT [pk_game_letter_bag] PRIMARY KEY CLUSTERED 
(
	[game_id] ASC,
	[letter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_game_board]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_game_board](
	[game_id] [int] NOT NULL,
	[board] [varchar](225) NOT NULL,
 CONSTRAINT [PK_tbl_game_board] PRIMARY KEY CLUSTERED 
(
	[game_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_current_player]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_current_player]
(  @game_id int, @player_id int)

RETURNS int
AS
BEGIN

	DECLARE @valid_flag int
	set @valid_flag =  (select COUNT(game_room.game_id) from 
			Scrabble.dbo.tbl_game_room as game_room
			where game_room.game_id = @game_id
			and  game_room.game_status  = STR( @player_id))
	RETURN @valid_flag

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_player_in_game]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_player_in_game]
( @game_id int,@player_id int)

RETURNS int
AS
BEGIN

	DECLARE @valid_flag int
	set @valid_flag =  (select COUNT(game_room.game_id) from 
			Scrabble.dbo.tbl_game_room as game_room
			where game_room.game_id = @game_id
			and @player_id in ( game_room.first_player_id ,game_room.second_player_id ))
	RETURN @valid_flag

END
GO
/****** Object:  StoredProcedure [dbo].[ssp_show_open_games]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ssp_show_open_games]
AS
BEGIN

DECLARE @game_id int
DECLARE @game_status varchar(50)
DECLARE @first_player_id int
DECLARE @first_player_name varchar(50)

DECLARE current_games CURSOR
STATIC FOR 
SELECT game_id,game_status,first_player_id,player_name from (select A.game_id ,A.game_status,A.first_player_id,B.player_name from tbl_game_room AS A,
										tbl_player AS B where A.first_player_id=B.player_id) jointTable
										where game_status='open'
		OPEN current_games
		IF @@CURSOR_ROWS > 0
		BEGIN 
			FETCH NEXT FROM current_games INTO @game_id,@game_status,@first_player_id,@first_player_name
			WHILE @@Fetch_status = 0
			BEGIN
				print '-----------------------------------------Game Details----------------------------------------------'
				PRINT 'Game_ID : '+ convert(varchar(3),@game_id)+' | Game Status : '+@game_status+' | First Player Id: '+convert(varchar(3),@first_player_id)+' | First Player Name:'+@first_player_name
				FETCH NEXT FROM current_games INTO @game_id,@game_status,@first_player_id,@first_player_name
			END
		END
CLOSE current_games
DEALLOCATE current_games
execute ssp_help										
END
GO
/****** Object:  StoredProcedure [dbo].[osp_swap_player]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[osp_swap_player]
(
@GameId int
)
AS
BEGIN
DECLARE @FirstplayerId int;
DECLARE @SecondplayerId int;
DECLARE @CurrentplayerId nchar(10);
SELECT @FirstplayerId=first_player_id, @SecondplayerId=second_player_id,@CurrentplayerId=game_status FROM tbl_game_room WHERE game_id=@GameId;
IF @CurrentplayerId= str(@FirstplayerId)
BEGIN
UPDATE tbl_game_room SET game_status=str(@SecondplayerId) WHERE game_id=@GameId;
RETURN
END
UPDATE tbl_game_room SET game_status=str(@FirstplayerId) WHERE game_id=@GameId;
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_get_game_status]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[ssp_get_game_status]
(
@game_id int
)
-- Add the parameters for the stored procedure here
AS
BEGIN
declare 
	@game_status nchar(20)
    -- Insert statements for procedure here
	select @game_status=game_status from tbl_game_room where game_id=@game_id
	return @game_status	
END
GO
/****** Object:  Table [dbo].[tbl_player_tray]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_player_tray](
	[player_id] [int] NOT NULL,
	[game_id] [int] NOT NULL,
	[tray_content] [nchar](7) NULL,
 CONSTRAINT [PK_tbl_player_tray] PRIMARY KEY CLUSTERED 
(
	[player_id] ASC,
	[game_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_player_recent_moves]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_player_recent_moves](
	[game_id] [int] NOT NULL,
	[player_id] [int] NOT NULL,
	[row_position] [int] NOT NULL,
	[col_position] [int] NOT NULL,
	[letter] [char](1) NOT NULL,
 CONSTRAINT [pk_tbl_player_recent_moves] PRIMARY KEY CLUSTERED 
(
	[game_id] ASC,
	[player_id] ASC,
	[row_position] ASC,
	[col_position] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ssp_update_player_score]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ssp_update_player_score]
@game_id int

AS
BEGIN
	Declare @row_position int
	Declare @col_position int
	Declare @letter char
	Declare @is_vertical int
	Declare @board varchar(255)
	
	select @board= board from tbl_game_board where game_id = @game_id
	
	select @is_vertical = COUNT(*) from tbl_player_recent_moves 
	where game_id = @game_id and row_position =
	(select top 1 moves.row_position
	from tbl_player_recent_moves moves 
	where moves.game_id = @game_id)
	
	if(@is_vertical != 1)
	begin
--	update_by_horizontal()
		select top 1 @row_position = moves.row_position, @col_position = moves.col_position
		from tbl_player_recent_moves moves where moves.game_id = @game_id
		
		-- find min index
		Declare @score int = 0
		Declare @indexCounter int = @col_position
		Declare @charAtIndexCounter char =
		 SUBSTRING(@board,@row_position*15 +@indexCounter,1)
		while(@charAtIndexCounter != '*' and (@indexCounter > 0))
		begin
		-- get score by tile type 
		select @score = points from tbl_letter_bag_m 
		where letter = (select tile_type from tbl_board_m where id= @indexCounter)
		--get score by letter 
		--select @score = points from tbl_letter_bag_m where letter= @charAtIndexCounter)
		
		set @indexCounter = @indexCounter -1
		set @charAtIndexCounter = SUBSTRING(@board,@row_position*15 +@indexCounter,1)
		end
		return 
	end
	
-- update_by_vertical()
	
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_update_board]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ssp_update_board]
	@game_id int AS
BEGIN
	Declare @board varchar(225)
	Declare @row_position int
	Declare @col_position int
	Declare @letter char
	
	select @board=board from dbo.tbl_game_board where game_id= @game_id 
	
	Declare result_set cursor
	static for
	(select row_position,col_position,letter from tbl_player_recent_moves where game_id= @game_id)

	OPEN result_set
		IF @@CURSOR_ROWS > 0
		BEGIN 
			FETCH NEXT FROM result_set INTO @row_position,@col_position,@letter
			Declare @letter_index  int =0
			set @letter_index = Scrabble.dbo.fn_get_letter_id_by_position(@row_position,@col_position);			
			set @board = STUFF(@board,@letter_index,1,@letter) 
		END
	CLOSE result_set
	DEALLOCATE result_set
	
	update Scrabble.dbo.tbl_game_board 
	set board = @board
	where game_id = @game_id
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_create_game]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ssp_create_game]
	@player_id int	
AS
BEGIN
	declare
	@STATUS nchar(30)
    -- Insert statements for procedure here
-- exec @player_id = ssp_get_player_id @name
	insert into tbl_game_room(first_player_id,game_status)values(@player_id,'open')
	--select * from tbl_game_room
	--select game_id from tbl_game_room where first_player_id=@ID	
	--select  * from tbl_game_room
	--EXEC @STATUS = ssp_GetGameStatus @ID
	
	--Following Statement gives the ID of the Last Record that was inserted in tbl_game_room
	print '| Game unique id to refer: ' +convert( varchar(10),@@IDENTITY) + '|'
		execute ssp_show_open_games		
END
GO
/****** Object:  StoredProcedure [dbo].[osp_UpdateLetterBag]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[osp_UpdateLetterBag]
( 
	-- Add the parameters for the stored procedure here	
 @game_id int,
 @character char
)
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
					
		UPDATE Scrabble.dbo.tbl_game_letter_bag
		SET letter_count = letter_count - 1
		WHERE game_id = @game_id 
		and letter = @character
END
GO
/****** Object:  StoredProcedure [dbo].[osp_ShowGame]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[osp_ShowGame]
	-- Add the parameters for the stored procedure here
	@game_id int  
AS
	DECLARE @board_row char(255);
	DECLARE @formatted_char varchar(100) = '';
	DECLARE @output_string varchar(100) = '';
	DECLARE @output_string_line varchar(100) = '';
	DECLARE @line_count int = 0;
	DECLARE @char_count int = 1;
	DECLARE @tile_type nchar(2) = 'bl';
	DECLARE @output_line_counter int = 1

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	print '    1   2   3   4   5   6   7   8   9  10  11  12  13  14  15 '
	WHILE @line_count < 15
	BEGIN
		--print CHAR(13)+CHAR(10)
			 
		select @board_row = SUBSTRING(board, (@line_count*15)+1, 15) from tbl_game_board
				  where game_id = @game_id;
 		set @output_string = @line_count + 1
 		if (@line_count < 9)
 		begin
 			set @output_string = @output_string + ' '
 		end
 		else
 		begin
 			set @output_string = @output_string
 		end
 		
 		while @char_count < 16 
 		begin
			set @formatted_char = '| ' + (select SUBSTRING(@board_row , @char_count, 1)) + ' '
			
			select @tile_type = tile_type from tbl_board_m 
				   where id = ((@line_count*15)+@char_count);
				   
			if((select SUBSTRING(@board_row , @char_count, 1))= '*')
				set @formatted_char = '|' + @tile_type + ' '
			
			set @output_string = @output_string + @formatted_char;
			
			set @char_count = @char_count + 1
		end
		
		set @output_string =  @output_string + '|'
		set @output_string_line = '--'
		while(@output_line_counter < (len(@output_string)- 2 ))
		begin
			set @output_string_line = @output_string_line + '|---'
			set @output_line_counter = @output_line_counter + 4
		end
			
		set	@output_string_line = @output_string_line + '|' 
		print @output_string_line
		print @output_string
			
		set	@output_string_line = ''
		set @output_string = ''
		set @line_count = @line_count + 1
		set @char_count = 1
		set @output_line_counter = 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[osp_remove_letter]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[osp_remove_letter]
(
@GameId int,
@PlayerId int,
@RowPos int,
@ColPos int,
@Message varchar(100) output
)
AS
BEGIN
--Declare @NoOfRowsFetched int;
DECLARE @LetterAtPos char;
Select  @LetterAtPos=letter from tbl_player_recent_moves where game_id=@GameId AND player_id=@PlayerId AND row_position=@RowPos AND col_position=@ColPos;
IF @LetterAtPos=null
BEGIN
SET @Message='No such letter put before';
return
END
DELETE FROM  tbl_player_recent_moves WHERE game_id=@GameId AND player_id=@PlayerId AND row_position=@RowPos AND col_position=@ColPos;
DECLARE @Tray varchar(7);
SELECT @Tray=tray_content FROM tbl_player_tray WHERE game_id=@GameId AND player_id=@PlayerId;
DECLARE @LetterIndex int;
set @LetterIndex = CHARINDEX('-',@Tray);
DECLARE @LeftString varchar(7);
DECLARE @RightString varchar(7);
set @LeftString=SUBSTRING(@Tray,1,@LetterIndex-1);
set @RightString=SUBSTRING(@Tray,@LetterIndex+1,7);
set @Tray=@LeftString+@LetterAtPos+@RightString;
update tbl_player_tray SET tray_content=@Tray where game_id=@GameId AND player_id=@PlayerId;
SET @Message='SUCCESS';
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_one_point_of_contact]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_one_point_of_contact]
 (@row int, @col int, @game_id int)
RETURNS int
AS
BEGIN
DECLARE @letter_index int
DECLARE @valid int =0
DECLARE @point_of_contact_count int = 0
DECLARE @index_of_letter_at_top int = 0
DECLARE @index_of_letter_at_bottom int = 0
DECLARE @index_of_letter_at_right int = 0
DECLARE @index_of_letter_at_left int = 0
DECLARE @board nchar(255)

	
	set @letter_index  = dbo.fn_get_letter_id_by_position(@row,@col)
	set @index_of_letter_at_top =  @letter_index -15
	set @index_of_letter_at_bottom =  @letter_index + 15
	set @index_of_letter_at_right =  @letter_index - 1
	set @index_of_letter_at_left =  @letter_index + 1
	
	--set @point_of_contact_count = 
	select @board= board from dbo.tbl_game_board
	
	if (@index_of_letter_at_top >0)
	begin
		set @point_of_contact_count = @point_of_contact_count + 
		dbo.fn_is_board_tile_occupied(@board,@index_of_letter_at_top)
	end
	
	
	if (@index_of_letter_at_bottom < 226)
	begin
		set @point_of_contact_count = @point_of_contact_count + 
		dbo.fn_is_board_tile_occupied(@board,@index_of_letter_at_bottom)
	end
	
		
	if (@index_of_letter_at_right >0)
	begin
		set @point_of_contact_count = @point_of_contact_count + 
		dbo.fn_is_board_tile_occupied(@board,@index_of_letter_at_right)
	end
	
		
	if (@index_of_letter_at_left < 226)
	begin
		set @point_of_contact_count = @point_of_contact_count + 
		dbo.fn_is_board_tile_occupied(@board,@index_of_letter_at_left)
	end

	if(@point_of_contact_count = 1 )
		return 1
	
	RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[osp_DeleteLetterRow]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[osp_DeleteLetterRow] 
	-- Add the parameters for the stored procedure here
	@game_id int,
	@letter char
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	delete from Scrabble.dbo.tbl_game_letter_bag 
     where game_id = @game_id 
     AND letter = @letter
  
    -- Insert statements for procedure here
	
END
GO
/****** Object:  StoredProcedure [dbo].[osp_check_and_update_player_tray]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[osp_check_and_update_player_tray]
(
@GameId int,
@PlayerId int,
@Letter char
)
AS
BEGIN
DECLARE @Tray nchar(7);
DECLARE @LetterIndex int;
SELECT @Tray=tray_content from tbl_player_tray where game_id=@GameId and player_id = @PlayerId;
set @LetterIndex = CHARINDEX(@Letter,@Tray);
if @LetterIndex  > 0
BEGIN
--select REPLACE(@Tray, @Letter, '*');
--SELECT STUFF(@Tray, CHARINDEX(@Letter, @Tray), 1, '*')
DECLARE @LeftString varchar(7);
DECLARE @RightString varchar(7);
set @LeftString=SUBSTRING(@Tray,1,@LetterIndex-1);
set @RightString=SUBSTRING(@Tray,@LetterIndex+1,7);
set @Tray=@LeftString+'-'+@RightString;
UPDATE tbl_player_tray SET tray_content=@Tray WHERE game_id=@GameId AND player_id=@PlayerId;
RETURN 1
END
ELSE
BEGIN
RETURN 0
END
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_valid_game]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_valid_game]
( @game_id int	)

RETURNS int
AS
BEGIN

	DECLARE @valid_flag int
	set @valid_flag = (select COUNT(game.game_id) from Scrabble.dbo.tbl_game_board as game where game.game_id= @game_id)
	RETURN @valid_flag

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_is_player_move_valid]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_is_player_move_valid]
(@game_id int)
RETURNS int
AS
BEGIN
	Declare @row_postition int =0, @col_postition int =0 , @letter char
	Declare @point_of_contact_count int = 0
	
	Declare result_set cursor
	static for
	(select row_position,col_position,letter from tbl_player_recent_moves where game_id= @game_id)

	OPEN result_set
		IF @@CURSOR_ROWS > 0
		BEGIN 
			FETCH NEXT FROM result_set INTO @row_postition,@col_postition,@letter
			set @point_of_contact_count = @point_of_contact_count + 
			Scrabble.dbo.fn_is_one_point_of_contact(@row_postition,@col_postition,@game_id)
		END
	CLOSE result_set
	DEALLOCATE result_set
	
	if(@point_of_contact_count = 1)
	 return 1
	 
	return 0

END
GO
/****** Object:  StoredProcedure [dbo].[osp_put_letter]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[osp_put_letter]
(
@GameId int,
@PlayerId int,
@RowPos int,
@ColPos int,
@Letter char,
@Message varchar(100) output
)
AS
BEGIN
	--Set @CurrentLetter = SUBSTRING(@Value,@ID,@ID+1);
	DECLARE @GameStatus nchar(10);
	select @GameStatus=game_status from tbl_game_room where game_id=@GameId;
	--check if player's turn to play the game
	
	IF @GameStatus='open'
	BEGIN
		set @Message= 'Waiting for second player to join the game'
		return
	END
	ELSE IF @GameStatus!=@PlayerId
	BEGIN
		set @Message= 'Please wait for another player to complete his/her turn'
		return 
	END

	--check if the existing board elements is not altered by user
	Declare @LetterAtReceivedPosition char;
	Declare @Board char(256);

	select @Board= board from tbl_game_board where game_id=@GameId;
	select @LetterAtReceivedPosition=SUBSTRING(@Board,(@RowPos)*15+(@ColPos),1);

	IF @LetterAtReceivedPosition!='*'
	BEGIN
		set @Message= 'The Character is already present at the position';
		return
	END

	DECLARE @RowMatchCount int;
	DECLARE @ColumnMatchCount int;
	DECLARE @TotalCount int;
	DECLARE @NoOfMatch int;

	--validations
	select @RowMatchCount=COUNT(*) from tbl_player_recent_moves where row_position=@RowPos;
	select @ColumnMatchCount=COUNT(*) from tbl_player_recent_moves where row_position=@ColPos;
	select @TotalCount=COUNT(*) from tbl_player_recent_moves;
	select @NoOfMatch=COUNT(*) from tbl_player_recent_moves where row_position=@RowPos AND col_position=@ColPos AND player_id=@PlayerId AND game_id=@GameId;

	IF @NoOfMatch > 0
	BEGIN
		SET @Message='The Character already exists at the position';
		return
	END
	
	IF @TotalCount=0
	BEGIN		
		--remove the element from tray
		DECLARE @Result int;
		EXECUTE @Result= scrabble.dbo.osp_check_and_update_player_tray @GameId,@PlayerId,@Letter 
		IF @Result= 0
		BEGIN 
			set @Message ='The letter should be present in the tray';
			RETURN
		END
		Execute osp_swap_player @GameId;
		INSERT INTO tbl_player_recent_moves VALUES (@GameId,@PlayerId,@RowPos,@ColPos,@Letter);
		Set @Message= 'SUCCESS1';
		return
	END
	
	IF @RowMatchCount=@TotalCount
	BEGIN
		DECLARE @RowPosValue int;
		select Top 1 @RowPosValue=row_position from tbl_player_recent_moves;
		IF @RowPosValue=@RowPos
		BEGIN
		EXECUTE @Result= scrabble.dbo.osp_check_and_update_player_tray @GameId,@PlayerId,@Letter 
		IF @Result= 0
		BEGIN 
			set @Message ='The letter should be present in the tray';
			RETURN
		END
		Execute osp_swap_player @GameId;
		set @Message= 'SUCCESS';
		Execute osp_swap_player @GameId;
		INSERT INTO tbl_player_recent_moves VALUES (@GameId,@PlayerId,@RowPos,@ColPos,@Letter);
		set @Message= 'SUCCESS';
		return
		END
	
		ELSE
		BEGIN
			set @Message= 'LETTERS PUT SHOULD BE EITHER IN HORIZONTAL OR VERTICAL ORDER';
		END
	End
	ELSE IF @ColumnMatchCount=@TotalCount
	BEGIN
		DECLARE @ColumnPosValue int;
		select Top 1 @ColumnPosValue=row_position from tbl_player_recent_moves;
	
		IF @ColumnPosValue=@RowPos
		BEGIN
			
		    EXECUTE @Result= scrabble.dbo.osp_check_and_update_player_tray @GameId,@PlayerId,@Letter 
			IF @Result= 0
			BEGIN 
				set @Message ='The letter should be present in the tray';
			RETURN
			END
			Execute osp_swap_player @GameId;
			set @Message= 'SUCCESS';
			Execute osp_swap_player @GameId;
			set @Message= 'SUCCESS';
			INSERT INTO tbl_player_recent_moves VALUES (@GameId,@PlayerId,@RowPos,@ColPos,@Letter);
			return
		END
	
		ELSE
		BEGIN
			set @Message= 'LETTERS PUT SHOULD BE EITHER IN HORIZONTAL OR VERTICAL ORDER2';
		END
	END
	
	ELSE
	BEGIN
		set @Message= 'LETTERS PUT SHOULD BE EITHER IN HORIZONTAL OR VERTICAL ORDER3';
	END

END
GO
/****** Object:  StoredProcedure [dbo].[osp_JoinGame]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[osp_JoinGame]
	-- Add the parameters for the stored procedure here
	@game_id int,
	@player_id int
AS
	DECLARE @gstatus varchar;
	DECLARE @tray varchar(7);
	DECLARE @player1 int;
	DECLARE @player2 int;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@player_id%2 = 1)
	begin
		set @gstatus = @player_id
	end
	else
	begin
		set @gstatus = (select first_player_id from tbl_game_room
								where game_id = @game_id)
	end
	
    -- Insert player 2 ID in game room table and set game status
	UPDATE Scrabble.DBO.tbl_game_room
		   SET second_player_id = @player_id,
			   game_status = @gstatus,
			   first_player_score = 0,
			   second_player_score = 0			   
		   WHERE game_id = @game_id;
	
	set @player1 = (select first_player_id from dbo.tbl_game_room
					where game_id=@game_id);
	set @player2 = @player_id;				
	-- Initialise game board with id and default values
	Declare @default_counter int = 1;
	Declare @default_board varchar(225)='';
	
	while(@default_counter <= 225)
	begin 
		set @default_board = @default_board +'*'
		set @default_counter = @default_counter + 1
	end
	
	INSERT INTO Scrabble.dbo.tbl_game_board (game_id,board)
		   VALUES ( @game_id,@default_board)

	-- Initialise letter bag for game 
	
	
	Insert into Scrabble.dbo.tbl_game_letter_bag
		Select A.game_id, B.letter, B.max_count 
		from Scrabble.dbo.tbl_game_room as A,
			 Scrabble.dbo.tbl_letter_bag_m as B
		where game_id = @game_id
	
	--Initialise letter trays
	--for player 1
	set @tray = (select char(rand()*26+97)+char(rand()*26+97)+
						char(rand()*26+97)+char(rand()*26+97)+
						char(rand()*26+97)+char(rand()*26+97)+
						char(rand()*26+97))
	
	Insert into Scrabble.dbo.tbl_player_tray (game_id,player_id,tray_content)
	select game_id, first_player_id, @tray
	from Scrabble.dbo.tbl_game_room
	where game_id = @game_id;
	
	--for player 2
	set @tray = (select char(rand()*26+97)+char(rand()*26+97)+
						char(rand()*26+97)+char(rand()*26+97)+
						char(rand()*26+97)+char(rand()*26+97)+
						char(rand()*26+97))
	
	Insert into Scrabble.dbo.tbl_player_tray (game_id,player_id,tray_content)
	select game_id, second_player_id, @tray 
	from Scrabble.dbo.tbl_game_room
	where game_id = @game_id;
	
	--Update letter bag for game
	
	declare @counter int = 0;
	declare @character char;
	
	
	--for 1st player
	while(@counter < 7)
	begin
		set @character = (select SUBSTRING((select tray_content from dbo.tbl_player_tray
								where player_id = @player1 and game_id = @game_id),
						  @counter,1));

		exec osp_UpdateLetterBag @game_id = @game_id,@character = @character
		set @counter = @counter + 1
	end
	
	set @counter = 0;
	--for 2nd player
	while(@counter < 7)
	begin
		set @character = (select SUBSTRING((select tray_content from dbo.tbl_player_tray
								where player_id = @player2 and game_id = @game_id),
						  @counter,1));

		exec osp_UpdateLetterBag @game_id = @game_id,@character = @character
		set @counter = @counter + 1
	end
	
exec dbo.osp_ShowGame @game_id
exec dbo.ssp_get_game_status @game_id	
END
GO
/****** Object:  StoredProcedure [dbo].[ssp_play]    Script Date: 08/29/2014 17:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ssp_play] 
@game_id int = 1,
@player_id int = 1
AS
Declare @valid_flag int = 0
BEGIN
	--checking valid game
	set @valid_flag =  scrabble.dbo.fn_is_valid_game( @game_id)
	if (@valid_flag != 1)
	begin 
		print 'game is invalid'
		return 
	end

	print 'game is valid'
	--checking valid player
	set @valid_flag = scrabble.dbo.fn_is_valid_player(@player_id)
	if(@valid_flag != 1)
	begin
		print 'player is invalid'
		return 
	end
	print 'player is valid'
	--checking game-player
	set @valid_flag = scrabble.dbo.fn_is_player_in_game(@game_id, @player_id)
	
	if(	@valid_flag != 1 )
	begin 
		print 'player-game is invalid'
		return 
	end

	print 'player-game is valid'
	--checking current-player
	set @valid_flag = scrabble.dbo.fn_is_current_player(@game_id, @player_id)
	if(	@valid_flag != 1 )
	begin
		print 'not your turn wait for other player to make move'
		return 
	end
	
	print 'You are currently playing'
	set @valid_flag = scrabble.dbo.fn_is_player_move_valid(@game_id)
	
	if(	@valid_flag != 1 )
	begin
		print 'invalid moves!! You are allowed to make moves with one point of contact only'
		return 
	end
-- updating board/ tray  /score/ swap players
	print 'valid move!!'	
	execute Scrabble.dbo.ssp_update_board @game_id
--	execute dbo.ssp_update_player_score(@game_id)	
END
GO
/****** Object:  ForeignKey [FK__tbl_game___first__30F848ED]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_game_room]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___first__30F848ED] FOREIGN KEY([first_player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_game_room] CHECK CONSTRAINT [FK__tbl_game___first__30F848ED]
GO
/****** Object:  ForeignKey [FK__tbl_game___secon__31EC6D26]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_game_room]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___secon__31EC6D26] FOREIGN KEY([second_player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_game_room] CHECK CONSTRAINT [FK__tbl_game___secon__31EC6D26]
GO
/****** Object:  ForeignKey [FK__tbl_game___game___300424B4]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_game_letter_bag]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___game___300424B4] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_game_letter_bag] CHECK CONSTRAINT [FK__tbl_game___game___300424B4]
GO
/****** Object:  ForeignKey [FK__tbl_game___game___2F10007B]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_game_board]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___game___2F10007B] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_game_board] CHECK CONSTRAINT [FK__tbl_game___game___2F10007B]
GO
/****** Object:  ForeignKey [FK_game_id]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_player_tray]  WITH CHECK ADD  CONSTRAINT [FK_game_id] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_player_tray] CHECK CONSTRAINT [FK_game_id]
GO
/****** Object:  ForeignKey [FK_player_id]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_player_tray]  WITH CHECK ADD  CONSTRAINT [FK_player_id] FOREIGN KEY([player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_player_tray] CHECK CONSTRAINT [FK_player_id]
GO
/****** Object:  ForeignKey [fk_game_id_on_tbl_player_recent_moves]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_player_recent_moves]  WITH CHECK ADD  CONSTRAINT [fk_game_id_on_tbl_player_recent_moves] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_player_recent_moves] CHECK CONSTRAINT [fk_game_id_on_tbl_player_recent_moves]
GO
/****** Object:  ForeignKey [fk_player_id_on_tbl_player_recent_moves]    Script Date: 08/29/2014 17:03:48 ******/
ALTER TABLE [dbo].[tbl_player_recent_moves]  WITH CHECK ADD  CONSTRAINT [fk_player_id_on_tbl_player_recent_moves] FOREIGN KEY([player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_player_recent_moves] CHECK CONSTRAINT [fk_player_id_on_tbl_player_recent_moves]
GO
