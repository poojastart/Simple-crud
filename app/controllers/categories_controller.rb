class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
    if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.turbo_stream do
          flash.now[:success] = "Category created successfully"
          render :create
        end
    else
        format.html { render :new }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
    if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.turbo_stream do
          flash.now[:success] = "Category updated successfully"
          render :update
        end
    else
        format.html { render :edit }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.turbo_stream do
        flash.now[:success] = "Category deleted successfully"
        render :destroy
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :image)
  end
end