# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do

  it { should respond_to(:email) }
  it { should respond_to(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it "performs minimal email address format validation" do
    should allow_value("email@example.com").for(:email)
    should_not allow_value("foo").for(:email)
    should_not allow_value("foo@").for(:email)
    should_not allow_value("foo@ex").for(:email)
    should_not allow_value("fo o@example.com").for(:email)
  end

end
