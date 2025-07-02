class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :update, :destroy, :edit]
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.ordered.page(params[:page])
  end

  def new
    authorize Product
    @product = Product.new
    @categories = Category.all
  end
  def create
    @product = current_user.products.build(product_params)
    if @product.save
      respond_to do |format|
        format.turbo_stream { redirect_to @product, notice: 'Product created successfully', status: :see_other }
        format.html { redirect_to @product, notice: 'Product created successfully', status: :see_other }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  def edit
    authorize @product
    @categories = Category.all
  end
  def update
    
    if @product.update(product_params)
      respond_to do |format|
        format.turbo_stream do
          flash.now[:notie] = "Product updated successfully"
          render :update
        end
        format.html { redirect_to @product, notice: 'Product Updted successfully' }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html {render :edit, status: :unprocessable_entity }
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
     params.require(:product).permit(:name, :description, :price, :compare_at_price, :image, :category_id)
  end
end
