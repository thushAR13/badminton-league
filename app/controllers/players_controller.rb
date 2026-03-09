class PlayersController < ApplicationController
  def index
    @new_player = Player.new
    @players = Player.order(:name)
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to players_path, notice: "Player creation succesful!!"
    else
      @new_player = @player
      @players = Players.order(:name)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    player = Player.find_by(id: params[:id])

    if player.nil?
      redirect_to players_path, alert: "Player not found"
    elsif player.destroy
      redirect_to players_path, notice: "Player removed succesfully!!"
    else
      redirect_to players_path, alert: player.errors.full_messages.to_sentence
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
