require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:player_one) { create(:player) }
  let(:player_two) { create(:player) }

  describe "validations" do
    it "is valid when the winner and loser are different players" do
      match = build(:match, winner: player_one, loser: player_two)
      expect(match).to be_valid
    end

    it "is invalid when the winner and loser are the same player" do
      match = build(:match, winner: player_one, loser: player_one)

      expect(match).not_to be_valid
      expect(match.errors[:base]).to include("Winner and loser must be different players")
    end
  end

  describe "associations" do
      it "belongs to a winner (Player)" do
        assoc = described_class.reflect_on_association(:winner)
        expect(assoc.macro).to eq(:belongs_to)
        expect(assoc.options[:class_name]).to eq("Player")
        expect(assoc.options[:counter_cache][:column]).to eq("wins")
      end

      it "belongs to a loser (Player)" do
        assoc = described_class.reflect_on_association(:loser)
        expect(assoc.macro).to eq(:belongs_to)
        expect(assoc.options[:class_name]).to eq("Player")
        expect(assoc.options[:counter_cache][:column]).to eq("losses")
      end
    end

  describe "counter caches" do
    it "increments wins for the winner and losses for the loser upon creation" do
      expect {
        create(:match, winner: player_one, loser: player_two)
      }.to change { player_one.reload.wins }.by(1)
       .and change { player_two.reload.losses }.by(1)
    end

    it "decrements wins and losses if the match is destroyed" do
      match = create(:match, winner: player_one, loser: player_two)
      expect {
        match.destroy
      }.to change { player_one.reload.wins }.by(-1)
       .and change { player_two.reload.losses }.by(-1)
    end
  end
end
