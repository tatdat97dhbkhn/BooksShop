class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true,
    length: {maximum: Settings.user.max_name}

  USER_CREATE_PARAMS = %w(name email password image).freeze
  USER_UPDATE_PARAMS = %w(password current_password).freeze
end
