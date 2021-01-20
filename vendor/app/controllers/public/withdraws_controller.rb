class Public::WithdrawsController < ApplicationController
  def new
    @cash_wallet = current_person.cash_wallet
    @transaction = Transaction.new
  end

  def create
    @cash_wallet = current_person.cash_wallet
    @transaction = Transaction.new(transaction_params)

    if @transaction.credit < ( @cash_wallet.success + @cash_wallet.request )

      @transaction.wallet_id = @cash_wallet.id
      @transaction.ref_no = "with_#{Transaction.all.count + 1}"
      @transaction.status = "request"

      if @transaction.save
        redirect_to person_wallets_url, notice: '<span class="text-semibold">Well done!</span> Your request for cash withdraw has been sent.'
      else
        render :new
      end
    else
      redirect_to new_person_withdraw_url, alert: '<span class="text-semibold">Alert!</span> Your request for cash withdraw failed.'
    end
  end

  private

    def transaction_params
      params.require(:transaction).permit(:description, :credit)
    end
end
