class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true,
    length: {maximum: Settings.user.max_name}
  mount_uploader :image, PictureUploader
  validate :image_size
  USER_CREATE_PARAMS = %w(name email password image).freeze
  USER_UPDATE_PARAMS = %w(password current_password).freeze

  private
  def image_size
    return unless image.size > Settings.image.capacity.megabytes
    errors.add :image, "should be less than 5MB"
  end
end
