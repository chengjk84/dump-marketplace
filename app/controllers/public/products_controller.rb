class Public::ProductsController < ApplicationController
  def index
    if params[:business_id].present?
      @business = Business.find(params[:business_id])
      @products = @business.products.where(active: true).order("id DESC").paginate(page: params[:page], per_page: 12)
    elsif params[:category_id]
      @products = Product.where(active: true, category_id: params[:category_id].to_i).order("id DESC").paginate(page: params[:page], per_page: 12)
    elsif params[:search]
      @products = Product.where(active: true).where(['name LIKE ?', "%#{params[:search]}%"]).order("id DESC").paginate(page: params[:page], per_page: 12)
    else
      @products = Product.where(active: true).order("id DESC").paginate(page: params[:page], per_page: 12)
    end

    #render :json => @people
  end

  def show
    @product = Product.find(params[:id])
  end
end
