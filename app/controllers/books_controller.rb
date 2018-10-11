class BooksController < ApplicationController
  before_action :find_book, only: %i(show edit update destroy)
  before_action :authenticate_user!, except: %i(home select_search search_book)
  
  def home
    @books = Book.all
  end

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = "Successfully created..."
      redirect_to books_path
    else
      flash[:danger] = "Fail created..."
      render :new
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
      render :edit
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

  def admin_params
    @search = params[:search]
    @table = params[:table]
    @search_cate = params[:search_cate]
  end

  def table_category search
    return @records = Category.search_categories(search) unless
      search.blank?
    @records = Category.all
  end

  def table_author search
    return @records = Author.search_author(search) unless search.blank?
    @records = Author.all
  end

  def table_book search
    @records = Book.all
    @records = Book.find_category(params[:category]) unless
      params[:category].blank?
    @records = Book.find_category(params[:search_cate]) unless
      params[:search_cate].blank?
    @records = @records.search_books(search) unless search.blank?
  end

  def admin_search
    admin_params
    if @table == "author"
      table_author @search
    elsif @table == "category"
      table_category @search
    elsif @table == "book"
      table_book @search
    end
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
