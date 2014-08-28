USE [master]
GO
/****** Object:  Database [Scrabble]    Script Date: 08/28/2014 20:04:57 ******/
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
/****** Object:  User [tavisca]    Script Date: 08/28/2014 20:04:57 ******/
CREATE USER [tavisca] FOR LOGIN [tavisca] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [pramod]    Script Date: 08/28/2014 20:04:57 ******/
CREATE USER [pramod] FOR LOGIN [team1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tbl_player]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_letter_bag_m]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_tile_type_m]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_board_m]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ssp_get_player_id]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_game_room]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_game_letter_bag]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_game_board]    Script Date: 08/28/2014 20:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_game_board](
	[game_id] [int] IDENTITY(1,1) NOT NULL,
	[board] [nchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ssp_show_open_games]    Script Date: 08/28/2014 20:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ssp_show_open_games]
AS
BEGIN
    -- Insert statements for procedure here
    --select game_id from (select A.game_id ,A.game_status,A.first_player_id,B.player_name from tbl_game_room AS A,
	--									tbl_player AS B where A.first_player_id=B.player_id) mytable
										--where game_status='open'
	select A.game_id ,A.game_status,A.first_player_id,B.player_name from tbl_game_room AS A,
										tbl_player AS B where A.first_player_id=B.player_id
									
										
END
GO
/****** Object:  Table [dbo].[tbl_player_tray]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  Table [dbo].[tbl_player_recent_moves]    Script Date: 08/28/2014 20:04:58 ******/
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
	[player_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ssp_get_game_status]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  StoredProcedure [dbo].[ssp_create_game]    Script Date: 08/28/2014 20:04:58 ******/
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
-- Add the parameters for the stored procedure here
AS
BEGIN
declare 
	@player_id int,
	@ID int,
	@name nchar(30),
	@STATUS nchar(30)
    -- Insert statements for procedure here
    set	@ID=6
    set @name='Dhruv'
	exec @player_id = ssp_get_player_id @name
	insert into tbl_game_room(first_player_id,game_status)values(@player_id,'open')
	--select * from tbl_game_room
	--select game_id from tbl_game_room where first_player_id=@ID	
	--select  * from tbl_game_room
	--EXEC @STATUS = ssp_GetGameStatus @ID
	
	--Following Statement gives the ID of the Last Record that was inserted in tbl_game_room
	print @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[scrbl_sp_play]    Script Date: 08/28/2014 20:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[scrbl_sp_play] 
@game_id int = 1,
@player_id int = 1
AS
Declare @valid_flag int = 0
BEGIN
--checking valid game
set @valid_flag = (select COUNT(game.game_id) from Scrabble.dbo.tbl_game_board as game where game.game_id= game_id)
	if (@valid_flag = 1)
	begin
		select 'game is valid'
		--checking valid player
		set @valid_flag = (select COUNT(player.player_id) from Scrabble.dbo.tbl_player as player where player.player_id= @player_id)
		if(@valid_flag = 1)
		begin
			select 'employee is valid'
			
			set @valid_flag = (select COUNT(game_room.game_id) from 
			Scrabble.dbo.tbl_game_room as game_room
			where game_room.game_id = @game_id
			and @player_id in ( game_room.first_player_id ,game_room.second_player_id ))
			
			if(	@valid_flag = 1 )
			begin
				select 'employee-game is valid'
			end
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[osp_ShowGame]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  StoredProcedure [dbo].[osp_put_letter]    Script Date: 08/28/2014 20:04:58 ******/
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
	DECLARE @GameStatus varchar(25);
	select @GameStatus=game_status from tbl_game_room where game_id=@GameId;
	--check if player's turn to play the game
	
	IF @GameStatus='open'
	BEGIN
		set @Message= 'Waiting for second player to join the game'
		
	END
	ELSE IF @GameStatus!=@PlayerId+''
	BEGIN
		set @Message= 'Please wait for another player to complete his/her turn'
		return 
	END

		--check if the existing board elements is not altered by user
		Declare @LetterAtReceivedPosition char;
		Declare @Board char(256);

		select @Board= board from tbl_game_board where game_id=@GameId;
		select @LetterAtReceivedPosition=SUBSTRING(@Board,@RowPos*15+@ColPos,1);

		IF @LetterAtReceivedPosition='*'
		BEGIN
			set @Message= 'The Character is alredy present at the position';
		END
		ELSE
		BEGIN
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
			END
			ELSE IF @TotalCount=0
			BEGIN
				INSERT INTO tbl_player_recent_moves VALUES (@GameId,@PlayerId,@RowPos,@ColPos,@Letter);
				set @Message= 'SUCCESS';
			END
			ELSE IF @RowMatchCount=@TotalCount
			BEGIN
				DECLARE @RowPosValue int;
				select Top 1 @RowPosValue=row_position from tbl_player_recent_moves;
			
				IF @RowPosValue=@RowPos
				BEGIN
					INSERT INTO tbl_player_recent_moves VALUES (@GameId,@PlayerId,@RowPos,@ColPos,@Letter);
					set @Message= 'SUCCESS';
			END
		ELSE
		BEGIN
			set @Message= 'LETTERS PUT SHOULD BE EITHER IN HORIZONTAL OR VERTICAL ORDER1';
		END
	End
ELSE IF @ColumnMatchCount=@TotalCount
	BEGIN
		DECLARE @ColumnPosValue int;
		select Top 1 @ColumnPosValue=row_position from tbl_player_recent_moves;
	
		IF @ColumnPosValue=@RowPos
		BEGIN
			INSERT INTO tbl_player_recent_moves VALUES (@GameId,@PlayerId,@RowPos,@ColPos,@Letter);
			set @Message= 'SUCCESS';
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
END
GO
/****** Object:  StoredProcedure [dbo].[osp_DeleteLetterRow]    Script Date: 08/28/2014 20:04:58 ******/
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
/****** Object:  ForeignKey [FK__tbl_game___first__30F848ED]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_game_room]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___first__30F848ED] FOREIGN KEY([first_player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_game_room] CHECK CONSTRAINT [FK__tbl_game___first__30F848ED]
GO
/****** Object:  ForeignKey [FK__tbl_game___secon__31EC6D26]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_game_room]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___secon__31EC6D26] FOREIGN KEY([second_player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_game_room] CHECK CONSTRAINT [FK__tbl_game___secon__31EC6D26]
GO
/****** Object:  ForeignKey [FK__tbl_game___game___300424B4]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_game_letter_bag]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___game___300424B4] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_game_letter_bag] CHECK CONSTRAINT [FK__tbl_game___game___300424B4]
GO
/****** Object:  ForeignKey [FK__tbl_game___game___2F10007B]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_game_board]  WITH CHECK ADD  CONSTRAINT [FK__tbl_game___game___2F10007B] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_game_board] CHECK CONSTRAINT [FK__tbl_game___game___2F10007B]
GO
/****** Object:  ForeignKey [FK_game_id]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_player_tray]  WITH CHECK ADD  CONSTRAINT [FK_game_id] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_player_tray] CHECK CONSTRAINT [FK_game_id]
GO
/****** Object:  ForeignKey [FK_player_id]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_player_tray]  WITH CHECK ADD  CONSTRAINT [FK_player_id] FOREIGN KEY([player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_player_tray] CHECK CONSTRAINT [FK_player_id]
GO
/****** Object:  ForeignKey [fk_game_id_on_tbl_player_recent_moves]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_player_recent_moves]  WITH CHECK ADD  CONSTRAINT [fk_game_id_on_tbl_player_recent_moves] FOREIGN KEY([game_id])
REFERENCES [dbo].[tbl_game_room] ([game_id])
GO
ALTER TABLE [dbo].[tbl_player_recent_moves] CHECK CONSTRAINT [fk_game_id_on_tbl_player_recent_moves]
GO
/****** Object:  ForeignKey [fk_player_id_on_tbl_player_recent_moves]    Script Date: 08/28/2014 20:04:58 ******/
ALTER TABLE [dbo].[tbl_player_recent_moves]  WITH CHECK ADD  CONSTRAINT [fk_player_id_on_tbl_player_recent_moves] FOREIGN KEY([player_id])
REFERENCES [dbo].[tbl_player] ([player_id])
GO
ALTER TABLE [dbo].[tbl_player_recent_moves] CHECK CONSTRAINT [fk_player_id_on_tbl_player_recent_moves]
GO
