require 'rails_helper'

RSpec.describe "Leaderboards", type: :request do
  describe "GET /index (Root Path)" do
    it "returns a successful response (200 OK)" do
      get root_path
      expect(response).to be_successful
    end

    it "displays players sorted correctly (most wins, then fewest losses)" do
      alice = create(:player, name: "Alice")
      bob = create(:player, name: "Bob")
      charlie = create(:player, name: "Charlie")

      create(:match, winner: alice, loser: bob)
      create(:match, winner: alice, loser: charlie)
      create(:match, winner: bob, loser: charlie)

      get root_path

      alice_position = response.body.index("Alice")
      bob_position = response.body.index("Bob")
      charlie_position = response.body.index("Charlie")

      expect(alice_position).to be < bob_position
      expect(bob_position).to be < charlie_position
    end
  end
end
