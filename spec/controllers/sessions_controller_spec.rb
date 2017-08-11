# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_ok
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create
      expect(response).to be_ok
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      delete :destroy
      expect(response).to redirect_to(login_url)
    end
  end

end
