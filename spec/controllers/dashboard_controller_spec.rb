# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to be_ok
    end
  end

end
