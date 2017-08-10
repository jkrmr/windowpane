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
  end

end
