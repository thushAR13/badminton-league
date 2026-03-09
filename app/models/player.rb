class Player < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :won_matches, class_name: "Match", foreign_key: "winner_id", dependent: :restrict_with_error
  has_many :lost_matches, class_name: "Match", foreign_key: "loser_id", dependent: :restrict_with_error
end
