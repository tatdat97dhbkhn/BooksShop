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
  PRICE_MIN = 1
  PRICE_MEDIUM = 2
  DATE_BEFORE = 1
  DATE_MIDDLE = 2
  MUSTY_THREE = 3
  MUSTY_SEVEN = 7
  MUSTY_TEN = 10

  scope :find_category, ->(id){where(category_id: id)}
  scope :find_author, ->(id){where(author_id: id)}
  scope :price_min, lambda{
    where("price >= #{MUSTY_THREE}
      and price <= #{MUSTY_SEVEN}")
  }
  scope :price_medium, lambda{
    where("price > #{MUSTY_SEVEN}
      and price < #{MUSTY_TEN}")
  }
  scope :price_max, ->{where("price >= 10")}
  scope :before_musty, ->{where("public_date < #{Date.new(2012, 1, 1)}")}
  scope :middle_musty, lambda{
    where("public_date >= #{Date.new(2012, 1, 1)}
      and public_date < #{Date.new(2015, 1, 1)}")
  }
  scope :after_musty, ->{where("public_date >= #{Date.new(2015, 1, 1)}")}
  scope :find_name, ->(name){where("name LIKE ?", "%#{name}%")}
  scope :search_books, lambda{|content|
    joins(:author, :category)
      .where("books.name LIKE ? or books.description LIKE ? or price LIKE ?
        or authors.name LIKE ? or categories.name LIKE ?", "%#{content}%",
        "%#{content}%", "%#{content}%", "%#{content}%", "%#{content}%")
  }

  class << self
    def search params
      books = Book.all

      category_id = params[:category_id].to_i
      author_id = params[:author_id].to_i
      price = params[:price].to_i
      public_date = params[:public_date].to_i

      unless params[:category_id].blank?
        books = books.find_category(category_id)
      end
      books = books.find_author(author_id) unless params[:author_id].blank?
      unless params[:price].blank?
        books = if price == PRICE_MIN
                  books.price_min
                elsif price == PRICE_MEDIUM
                  books.price_medium
                else
                  books.price_max
                end
      end
      unless params[:public_date].blank?
        books = if public_date == DATE_BEFORE
                  books.before_musty
                elsif public_date == DATE_MIDDLE
                  books.middle_musty
                else
                  books.after_musty
                end
      end
      books
    end
  end

  private
  def image_size
    return unless image.size > Settings.image.capacity.megabytes
    errors.add :image, "should be less than 5MB"
  end
end
