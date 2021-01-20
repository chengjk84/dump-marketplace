class Admin::Businesses::VerificationsController < Admin::BaseController
  #before_action :authenticate_admin!

  def index
    @businesses = Business.got_certificate.where(verified: false).paginate(page: params[:page], per_page: 12).order('updated_at DESC')
  end

  def update
    @business = Business.find(params[:id])
    @business.update_attributes(verified: true)
    redirect_to admin_businesses_verifications_url, notice: '<span class="text-semibold">Well done!</span> Business has been verified.'
  end
end
