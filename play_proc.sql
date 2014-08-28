USE [Scrabble]
GO

/****** Object:  StoredProcedure [dbo].[scrbl_sp_play]    Script Date: 08/28/2014 13:46:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**
validations
	game_id DONE 
	player_id DONE
	player_game 
	current_player
**/
	
Alter PROCEDURE [dbo].[scrbl_sp_play] 
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

exec dbo.scrbl_sp_play 
@GameId int,
@PlayerId int,
@RowPos int,
@ColPos int,
@Letter char,
@Message varchar(100) output

Declare @OutputMessage varchar(100) = ''
exec scrabble.dbo.[osp_put_letter] @GameId =1, @PlayerId =2, @RowPos =1, @ColPos =4, @Letter = 'A', @Message =@OutputMessage output

select @OutputMessage
exec dbo.ssp_show_open_games

exec [dbo].[osp_put_letter] @GameId =1