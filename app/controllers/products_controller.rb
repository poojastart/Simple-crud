class ProductsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:show, :update, :destroy, :edit]
  def index
    @products = Product.page params[:page]
    @products = @products.ordered
  end

  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      respond_to do |format|
        redirect_to @product, notice: 'Product created successfully'
        format.turbo_stream
      end
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
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @product, notice: 'Product Updted successfully' }
      end
    else
      respond_to do |format|
        format.turbo_stream
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @product.destroy
      respond_to do |format|
        format.html{ redirect_to @products, notice: 'Product deleted successfully' }
        format.turbo_stream
      end
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
