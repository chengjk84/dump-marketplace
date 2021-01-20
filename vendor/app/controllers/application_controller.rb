class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_person, :navigate_by_type, :navigate_by_list, :navigate_by_category

  before_action :capture_sponsor, :capture_billplz

  def authenticate_admin!
    if current_person.admin
      true
    else
      redirect_to root_url, alert: '<span class="text-semibold">Oh snap!</span> You are not authorized to entered the admin area.'
    end
  end

  private
    def current_person
      @current_person ||= Person.find_by_uuid!(cookies[:uuid]) if cookies[:uuid]
    end

    def capture_sponsor
      cookies[:sponsor_token] = params[:sponsor_token] if params[:sponsor_token]
    end

    def capture_billplz
      if session[:billplz_bill_id]
        bill = Billplz::Bill.new({ bill_id: session[:billplz_bill_id]})
        if bill.get

          if bill.parsed_json['paid']
            ref_no = "depo_#{bill.parsed_json['id']}"
            transaction = Transaction.find_by_ref_no(ref_no)

            if transaction.present?
              transaction.update_attributes(status: "success")
              session[:billplz_bill_id] = nil
              Journal.create!(name: "Creditor", remark: "Top up money to Atlantis2U", ref_no: transaction.ref_no, credit: transaction.debit)
              Journal.create!(name: "Bank", remark: "Top up money to Atlantis2U", ref_no: transaction.ref_no, debit: transaction.debit)
              flash.now.notice = '<span class="text-semibold">Top Up Success!</span> Enjoy your time with us.'
            end
          else
            ref_no = "depo_#{bill.parsed_json['id']}"
            transaction = Transaction.find_by_ref_no(ref_no)

            if transaction.present?
              transaction.update_attributes(status: "cancel")
              session[:billplz_bill_id] = nil
              flash.now.alert = '<span class="text-semibold">Oh snap!</span> Your top up request has failed.'
            end

          end
        end
      end
    end

    def navigate_by_type
      @navigate_by_type ||= Type.all
    end

    def navigate_by_list
      @navigate_by_list ||= List.all
    end

    def navigate_by_category
      @navigate_by_category ||= Category.all
    end

end
