class Public::DepositsController < ApplicationController
  def new
    @cash_wallet = current_person.cash_wallet
    @transaction = Transaction.new
  end

  def create

    if params[:first_name].present? && params[:last_name].present? && params[:email].present? && params[:amount].present?
      if Rails.env.production?
        collection_id = ENV['BILLPLZ_COLLECTION_ID']
      else
        collection_id = "8y_hggmm"
      end

      billplz_fees = 0.00
      if params[:amount].to_f < 100
        billplz_fees = 1.50
      end

      @bill = Billplz::Bill.new({
        collection_id: collection_id,
        name: "#{params[:first_name]} #{params[:last_name]}",
        email: params[:email],
        amount: "#{((params[:amount].to_f + billplz_fees) * 100).to_i}",
        callback_url: "#{request.base_url}",
        redirect_url: "#{person_wallets_url(current_person)}" })

      @bill.create

      if @bill.success?
        session[:billplz_bill_id] = @bill.parsed_json["id"]

        transaction = Transaction.new
        transaction.wallet_id = current_person.cash_wallet.id
        transaction.description = "Top up cash to wallet"
        transaction.ref_no = "depo_#{@bill.parsed_json["id"]}"
        transaction.debit = (@bill.parsed_json["amount"].to_f / 100) - billplz_fees
        transaction.status = "pending"

        if transaction.save
          redirect_to (@bill.parsed_json["url"] + "?auto_submit=fpx")

        else
          @bill.delete
          flash.now.alert = '<span class="text-semibold">Transaction Error!</span> Your request for cash deposit failed.'
          render :new
        end
      else
        flash.now.alert = '<span class="text-semibold">Billing Error!</span> Your request for cash deposit failed.'
        render :new
      end
    else
      flash.now.alert = '<span class="text-semibold">Alert!</span> Your must fill up all fields.'
      render :new
    end

  end

  private

    def transaction_params
      params.require(:transaction).permit(:description, :credit)
    end
end
