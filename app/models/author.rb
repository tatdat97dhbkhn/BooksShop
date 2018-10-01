class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.author.max_name}
end
