class Public::Merchant::ConversationsController < ApplicationController
  def index
    @business = Business.find(params[:business_id])
    @conversations = @business.conversations
  end

  def show
    @business = Business.find(params[:business_id])
    @conversations = @business.conversations
    @conversation = @business.conversations.find(params[:id])
  end

  def create
    @business = Business.find(params[:business_id])
    conversation = @business.conversations.find_by_person_id(params[:person_id])

    if conversation.present?
      conversation.messages.create!(content: params[:message_content], remark: "business")
      conversation.update_attributes(person_response: false, business_response: true)
      redirect_to business_merchant_conversation_url(@business, conversation), notice: '<span class="text-semibold">Well done!</span> Message has been sent to merchant.'
    else
      @business.conversations.create!(person_id: params[:person_id])
      conversation = @business.conversations.find_by_person_id(params[:preson_id])
      conversation.messages.create!(content: params[:message_content], remark: "business")
      conversation.update_attributes(person_response: false, business_response: true)
      redirect_to business_merchant_conversation_url(@business, conversation), notice: '<span class="text-semibold">Well done!</span> Message has been sent to merchant.'
    end
  end
end
