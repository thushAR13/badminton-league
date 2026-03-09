require 'rails_helper'

RSpec.describe "Players", type: :request do
  let!(:existing_player) { create(:player, name: "Alice") }

  describe "GET /index" do
    it "returns a successful response (200 OK)" do
      get players_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_params) { { player: { name: "Bob" } } }

      it "creates a new Player" do
        expect {
          post players_path, params: valid_params
        }.to change(Player, :count).by(1)
      end

      it "redirects to the players index with a success notice" do
        post players_path, params: valid_params
        expect(response).to redirect_to(players_path)
        expect(flash[:notice]).to eq("Player creation succesful!!")
      end
    end

    context "with invalid parameters (e.g., duplicate name)" do
      let(:invalid_params) { { player: { name: "Alice" } } }

      it "does not create a new Player" do
        expect {
          post players_path, params: invalid_params
        }.not_to change(Player, :count)
      end

      it "returns a 422 Unprocessable Entity status" do
        post players_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the player exists and has no matches" do
      it "deletes the player" do
        expect {
          delete player_path(existing_player)
        }.to change(Player, :count).by(-1)
      end

      it "redirects to the players index with a success notice" do
        delete player_path(existing_player)
        expect(response).to redirect_to(players_path)
        expect(flash[:notice]).to eq("Player removed succesfully!!")
      end
    end

    context "when the player does not exist" do
      it "does not crash and redirects with an alert" do
        delete player_path(id: 99999)
        expect(response).to redirect_to(players_path)
        expect(flash[:alert]).to eq("Player not found")
      end
    end

    context "when the player cannot be deleted due to match history" do
      let!(:opponent) { create(:player, name: "Charlie") }
      let!(:match) { create(:match, winner: existing_player, loser: opponent) }

      it "does not delete the player" do
        expect {
          delete player_path(existing_player)
        }.not_to change(Player, :count)
      end

      it "redirects with an alert containing the validation error" do
        delete player_path(existing_player)
        expect(response).to redirect_to(players_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
