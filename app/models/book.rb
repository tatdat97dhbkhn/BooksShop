class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category

  validates :name, presence: true,
    length: {maximum: Settings.book.max_name}

  validates :description, presence: true

  validates :price, presence: true

  validates :public_date, presence: true
end
