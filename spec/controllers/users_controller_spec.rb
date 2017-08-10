# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_ok
    end
  end

  describe "POST #create" do
    context "given a successful login" do
      it "returns a success response" do
        get :create, params: { user: attributes_for(:user) }

        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to be_blank
        expect(flash[:notice]).to eq "Welcome!"
      end
    end

    context "given an unsuccessful login" do
      it "returns a success response" do
        get :create, params: { user: { email: ""} }

        expect(response).to be_not_found
        expect(flash[:alert]).to_not be_blank
        expect(flash[:notice]).to be_blank
      end
    end
  end

end
