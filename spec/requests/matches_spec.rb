require 'rails_helper'

RSpec.describe "Matches", type: :request do
  let!(:player_one) { create(:player) }
  let!(:player_two) { create(:player) }

  describe "GET /index" do
    it "returns a successful response (200 OK)" do
      create(:match, winner: player_one, loser: player_two)
      get matches_path
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "returns a successful response (200 OK)" do
      get new_match_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_params) do
        { match: { winner_id: player_one.id, loser_id: player_two.id } }
      end

      it "creates a new Match in the database" do
        expect {
          post matches_path, params: valid_params
        }.to change(Match, :count).by(1)
      end

      it "redirects to the root path with a success notice" do
        post matches_path, params: valid_params
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Match succesfully created!!")
      end
    end

    context "with invalid parameters (same player selected)" do
      let(:invalid_params) do
        { match: { winner_id: player_one.id, loser_id: player_one.id } }
      end

      it "does not create a new Match" do
        expect {
          post matches_path, params: invalid_params
        }.not_to change(Match, :count)
      end

      it "returns a 422 Unprocessable Entity status to render the form again" do
        post matches_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end