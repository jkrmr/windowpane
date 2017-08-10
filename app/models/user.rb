# frozen_string_literal: true

class User < ApplicationRecord

  validates :email,
            :name,
            :password,
            :password_confirmation,
            presence: true

  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: /\A\S+@\S+\.\S+\Z/

  has_secure_password

end
