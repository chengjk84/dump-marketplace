class Public::BusinessesController < ApplicationController
  def index
    @businesses = Business.all
    if params[:person_id]
      @person = Person.find(params[:person_id])
      @businesses = @person.businesses.paginate(page: params[:page], per_page: 12)
    elsif params[:list_id]
      @businesses = Business.where(active: true, list_id: params[:list_id].to_i).paginate(page: params[:page], per_page: 12)
    else
      @businesses = Business.where(active: true).paginate(page: params[:page], per_page: 12)
    end

  end

  def show
    @business = Business.find(params[:id])
    @products = @business.products.where(featured: true).sample(4)
  end

  def edit
    @business = Business.find(params[:id])
  end

  def new
    @business = current_person.businesses.build
  end

  def create
    @business = current_person.businesses.build(business_params)

    if current_person.sponsor_id.present?
      @business.referrer_id = current_person.sponsor_id
    end

    if @business.save
      redirect_to business_merchant_root_url(@business), notice: '<span class="text-semibold">Well done!</span> Your new business have been created.'
    else
      render :new
    end
  end

  def update
    @business = Business.find(params[:id])

    if @business.update(business_params)
      redirect_to edit_business_path(@business), notice: '<span class="text-semibold">Well done!</span> Your business information have been updated.'
    else
      render :edit
    end
  end

  private

    def business_params
      params.require(:business).permit(
        :person_id, :referrer_id,
        :name, :email, :mobile,
        :bank_name, :bank_account_no, :bank_account_name,
        :certificate_id, :certificate_photo,
        :gst_no, :gst_certification_photo,
        :logo, :banner,
        :about,
        :phone, :fax,
        :street_1, :street_2, :city, :postcode, :state, :country,
        :lng, :lat,
        :type_id, :list_id
      )
    end
end
