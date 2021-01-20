class Public::SubscriptionsController < ApplicationController
  def index
    @subscriptions = current_person.subscriptions.last(12).reverse
  end

  def new
    @plans = Plan.all
  end

  def create
    @plan = Plan.find(params[:plan_id])

    if @plan.price < current_person.cash_wallet.success
      @subscription = current_person.subscriptions.build
      @subscription.plan_id = params[:plan_id].to_i
      @subscription.expired_at = 30.days.from_now

      if @subscription.save
        transaction = Transaction.new
        transaction.wallet_id = current_person.cash_wallet.id
        transaction.description = "Subscribe to #{@plan.name} membership"
        transaction.ref_no = "subs_#{@subscription.id}"
        transaction.credit = @plan.price
        transaction.status = "success"
        transaction.save
        redirect_to person_subscriptions_url, notice: '<span class="text-semibold">Well done!</span> Your membership upgrade success.'
      else
        flash.now.alert = '<span class="text-semibold">Oh snap!</span> Your membership upgrade was failed.'
        render :new
      end
    else
      redirect_to new_person_deposit_url(current_person), alert: '<span class="text-semibold">Oh snap!</span> Please top up your wallet first.'
    end
  end
end
