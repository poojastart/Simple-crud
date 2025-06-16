class ProductsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:show, :update, :destroy, :edit]
  def index
    @products = Product.page params[:page]
  end

  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      # render json: @product, status: :created
      redirect_to @product, notice: 'Product created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  def edit
  end
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product Updted successfully'
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: 'Product deleted successfully'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
     params.require(:product).permit(:name, :description, :price, :image)
  end
end
