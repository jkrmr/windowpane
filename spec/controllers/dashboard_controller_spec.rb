# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      user = create(:user)
      log_in(user)

      get :index

      expect(response).to be_ok
    end

    context "given an unauthenticated user" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to \
          eq "Terribly sorry, would you mind logging in, please?"
      end
    end
  end

end
