class Match < ApplicationRecord
  belongs_to :winner, class_name: "Player", counter_cache: :wins
  belongs_to :loser, class_name: "Player", counter_cache: :losses

  validate :players_must_be_different

  private

  def players_must_be_different
    if winner_id.present? && winner_id == loser_id
      errors.add(:base, "Winner and loser must be different players")
    end
  end
end