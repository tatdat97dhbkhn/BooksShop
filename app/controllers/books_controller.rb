class BooksController < ApplicationController
  before_action :find_book, only: %i(show edit update destroy)

  def home
    @books = Book.all
  end

  def index
    @books = Book.all.page(params[:page]).per_page Settings.page.limit
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = "Successfully created..."
      redirect_to request.referer
    else
      flash[:danger] = "Fail created..."
      redirect_to :new
    end
  end

  def destroy
    @book.destroy
  end

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = "Update successfull!"
      redirect_to books_path
    else
      flash[:danger] = "Fail"
      redirect_to request.referer
    end
  end

  def select_search
    @books = Book.search params
  end

  def search_book
    @name = params[:name_search]
    return @books = Book.find_name(@name) unless @name.empty?
    @books = Book.all
  end

  private
  def book_params
    params.require(:book).permit Book::BOOK_PARAMS
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = "Do not find category..."
    redirect_to books_path
  end
end
