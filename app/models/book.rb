class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category

  validates :name, presence: true,
    length: {maximum: Settings.book.max_name}
  validates :price, presence: true
  validates :public_date, presence: true
  validates :category_id, presence: true
  mount_uploader :image, PictureUploader
  validate :image_size
  BOOK_PARAMS = %w(name category_id description
    image author_id price public_date).freeze
  BOOK_ATTR = %w(id name description price public_date
    image category_id _destroy).freeze

  private
  def image_size
    return unless image.size > Settings.image.capacity.megabytes
    errors.add :image, "should be less than 5MB"
  end
end
