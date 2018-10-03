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

  scope :find_category, ->(id){where(category_id: id)}
  scope :find_author, ->(id){where(author_id: id)}
  scope :price_min, ->{where("price >= 3 and price <= 7")}
  scope :price_medium, ->{where("price > 7 and price < 10")}
  scope :price_max, ->{where("price >= 10")}
  scope :before_musty, ->{where("public_date < #{Date.new(2012, 1, 1)}")}
  scope :middle_musty, lambda{
    where("public_date >= #{Date.new(2012, 1, 1)}
      and public_date < #{Date.new(2015, 1, 1)}")}
  scope :after_musty, ->{where("public_date >= #{Date.new(2015, 1, 1)}")}
  scope :find_name, ->(name){where("name LIKE ?", "%#{name}%")}
  scope :search_books, lambda{|content|
    joins(:author, :category).
      where("books.name LIKE ? or books.description LIKE ? or price LIKE ? 
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
        books = if price == 1
                  books.price_min
                elsif price == 2
                  books.price_medium
                else
                  books.price_max
                end
      end
      unless params[:public_date].blank?
        books = if public_date == 1
                  books.before_musty
                elsif public_date == 2
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
