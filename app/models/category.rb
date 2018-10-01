class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true,
    length: {maximum: Settings.category.max_name}

  validates :description, presence: true
end
