class MatchesController < ApplicationController
  def index
    @matches = Match.includes(:winner, :loser).order(created_at: :desc)
  end

  def new
    @match = Match.new
    @players = Player.order(:name)
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to root_path, notice: "Match succesfully created!!"
    else
      @players = Player.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def match_params
    params.require(:match).permit(:winner_id, :loser_id)
  end
end
