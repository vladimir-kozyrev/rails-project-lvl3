# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :admin, inclusion: [true, false]
  has_many :bulletins

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(email: auth['info']['email'])
    user.name = auth['info']['name']
    user.save
    user
  end

  def admin?
    admin
  end
end
