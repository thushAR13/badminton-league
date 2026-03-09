require 'rails_helper'

RSpec.describe Match, type: :model do
  # FactoryBot makes setting up our test variables incredibly clean
  let(:player_a) { create(:player) }
  let(:player_b) { create(:player) }

  describe "validations" do
    it "is valid with a different winner and loser" do
      # build() creates the object in memory without saving to the database yet
      match = build(:match, winner: player_a, loser: player_b)
      expect(match).to be_valid
    end

    it "is invalid if the winner and loser are the same player" do
      match = build(:match, winner: player_a, loser: player_a)
      
      expect(match).not_to be_valid
      expect(match.errors[:base]).to include("Winner and loser must be different players")
    end
  end

  describe "associations" do
    it "belongs to a winner and loser" do
      match = build(:match, winner: player_a, loser: player_b)
      
      expect(match.winner).to eq(player_a)
      expect(match.loser).to eq(player_b)
    end
  end

  describe "counter caches" do
    it "increments the winner's wins and loser's losses upon creation" do
      expect {
        create(:match, winner: player_a, loser: player_b)
      }.to change { player_a.reload.wins }.by(1)
       .and change { player_b.reload.losses }.by(1)
    end

    it "decrements the stats if a match is destroyed" do
      match = create(:match, winner: player_a, loser: player_b)
      
      expect {
        match.destroy
      }.to change { player_a.reload.wins }.by(-1)
       .and change { player_b.reload.losses }.by(-1)
    end
  end
end