# frozen_string_literal: true

require "rails_helper"

RSpec.describe Feed, type: :model do

  it { should respond_to(:username) }
  it { should respond_to(:payload) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:payload) }

end
