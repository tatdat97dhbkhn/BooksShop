class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  accepts_nested_attributes_for :books, allow_destroy: true,
    reject_if: ->(attrs){
      attrs["name"].blank? || attrs["price"].blank? ||
      attrs["public_date"].blank? || attrs["category_id"].blank?}             

  validates :name, presence: true,
    length: {maximum: Settings.author.max_name}
end
