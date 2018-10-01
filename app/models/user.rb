class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true,
    length: {maximum: Settings.user.max_name}
end
