class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true,
    length: {maximum: Settings.category.max_name}

  scope :search_categories, lambda{|content| 
    where("name LIKE ? or description LIKE ?", 
    "%#{content}%", "%#{content}%")}

  CATEGORY_PARAMS = %w(name description).freeze
end
