class AuthorsController < ApplicationController
  before_action :find_author, only: %i(show edit update destroy)
  before_action :authenticate_user!
  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
    Settings.number_one.times{@author.books.new}
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = "Successfully created..."
      redirect_to authors_path
    else
      flash[:danger] = "Fail created..."
      render :new
    end
  end

  def destroy
    @author.destroy
  end

  private
  def find_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = "Do not find category..."
    redirect_to authors_path
  end

  def author_params
    params.require(:author).permit(:name, books_attributes: Book::BOOK_ATTR)
  end
end
