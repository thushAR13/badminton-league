class LeaderboardController < ApplicationController
  def index
    @players = Player.order(wins: :desc, losses: :asc)
  end
end