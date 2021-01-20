class Public::Merchant::ProductsController < ApplicationController
  def index
    @business = Business.find(params[:business_id])
    @products = @business.products.active_products.where(['name LIKE ?', "%#{params[:search]}%"]).paginate(page: params[:page], per_page: 8).order('created_at DESC')
  end

  def new
    @business = Business.find(params[:business_id])
    @product = @business.products.build
  end

  def edit
    @business = Business.find(params[:business_id])
    @product = @business.products.find(params[:id])
  end

  def create
    @business = Business.find(params[:business_id])
    @product = @business.products.build(product_params)

    if @product.save
      redirect_to business_merchant_products_url, notice: '<span class="text-semibold">Well done!</span> Your product information have been saved.'
    else
      render :new
    end
  end

  def update
    @person = current_person

    @business = Business.find(params[:business_id])
    @product = @business.products.find(params[:id])

    if @product.update(product_params)
      redirect_to business_merchant_products_url, notice: '<span class="text-semibold">Well done!</span> Your product information have been updated.'
    else
      render :edit
    end

  end

  def destroy
    @Product = Product.find(params[:id])
    @Product.update_attributes(active: false)
    redirect_to :back, notice: '<span class="text-semibold">Well done!</span>The product has been disabled.'
  end

  private

    def product_params
      params.require(:product).permit(
        :name, :description, :category_id,
        :price, :promotion,
        :shipment_peninsular, :shipment_sabah, :shipment_sarawak,
        :image_01, :image_02, :image_03, :image_04, :image_05, :featured)
    end
end
