class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  has_scope :by_name, only: :index

  # GET /products
  def index
    @products = Product.all
    if(params[:order]=="asc")
      render json: apply_scopes(@products.order(value: :asc))
    else
      render json: apply_scopes(@products.order(value: :desc))
    end
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :category_id, :measure_id, :stock, :value, :highlight, :image)
    end
end
