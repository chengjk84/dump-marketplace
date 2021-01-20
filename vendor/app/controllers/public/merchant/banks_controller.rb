class Public::Merchant::BanksController < ApplicationController
  def index
    @business = Business.find(params[:business_id])
    @bank = @business.bank
    @statements = @bank.statements.paginate(page: params[:page], per_page: 12)
  end
end
