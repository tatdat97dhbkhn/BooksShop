class CategoriesController < ApplicationController
  before_action :find_category, only: %i(show edit update destroy)
  before_action :authenticate_user!
  def index; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Successfully created..."
      redirect_to categories_path
    else
      flash[:danger] = "Fail created..."
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Update successfull!"

      redirect_to categories_path
    else
      flash[:danger] = "Fail"
      render :edit
    end
  end

  def destroy
    @category.destroy
  end

  private
  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = "Do not find category..."
    redirect_to root_path
  end
end
