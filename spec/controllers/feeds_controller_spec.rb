# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      VCR.use_cassette("twitter-api-everythinggoats-25") do
        log_in(create(:user))
        get :show, params: { username: "everythinggoats" }
        expect(response).to be_ok
      end
    end

    context "given an empty username param" do
      it "returns http success" do
        log_in(create(:user))
        get :show, params: { username: "" }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq "Please provide a Twitter handle."
      end
    end

    context "given an unauthenticated user" do
      it "redirects to the login page" do
        get :show
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to \
          eq "Terribly sorry, would you mind logging in, please?"
      end
    end
  end

end
