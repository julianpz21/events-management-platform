require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) { create(:user) }
  let!(:events) { create_list(:event, 3) }
  let(:headers) { { Authorization: "Bearer #{user_jwt_token}" } }

  def user_jwt_token
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end

  describe "GET /events" do
    context "when the user is authenticated" do
      it "returns a successful response  a list of events" do
        get api_v1_events_path, headers: headers

        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(3)
      end
    end
  end
end
