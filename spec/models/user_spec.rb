# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }

end
