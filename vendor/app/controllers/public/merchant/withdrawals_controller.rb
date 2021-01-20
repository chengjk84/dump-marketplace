class Public::Merchant::WithdrawalsController < ApplicationController
  def index
    @business = Business.find(params[:business_id])
    @bank = @business.bank
    @statements = @bank.statements.where(["ref_no LIKE ?", "WITH%"]).paginate(page: params[:page], per_page: 8).order('created_at DESC')
  end

  def new
    @business = Business.find(params[:business_id])
    @bank = @business.bank
    @statement = @bank.statements.build
  end

  def create
    @business = Business.find(params[:business_id])
    @bank = @business.bank
    @statement = @bank.statements.build(statement_params)
    @statement.ref_no = "WITH-#{Statement.all.count + 1}"
    @statement.status = "request"

    if @statement.credit < ( @bank.success + @bank.request )
      if @statement.save
        redirect_to business_merchant_withdrawals_url, notice: '<span class="text-semibold">Well done!</span> Your request for credit withdraw has been sent.'
      else
        render :new
      end
    else
      redirect_to new_business_merchant_withdrawal_url, alert: '<span class="text-semibold">Alert!</span> Your request for credit withdraw failed.'
    end

  end

  private

    def statement_params
      params.require(:statement).permit(:description, :credit)
    end
end
