class Public::ConversationsController < ApplicationController
  def index
    @conversations = current_person.conversations
  end

  def show
    @conversations = current_person.conversations
    @conversation = current_person.conversations.find(params[:id])
  end

  def create
    conversation = current_person.conversations.find_by_business_id(params[:business_id])

    if conversation.present?
      conversation.messages.create!(content: params[:message_content], remark: "person")
      conversation.update_attributes(person_response: true, business_response: false)
      redirect_to person_conversation_url(current_person, conversation), notice: '<span class="text-semibold">Well done!</span> Message has been sent to merchant.'
    else
      current_person.conversations.create!(business_id: params[:business_id])
      conversation = current_person.conversations.find_by_business_id(params[:business_id])
      conversation.messages.create!(content: params[:message_content], remark: "person")
      conversation.update_attributes(person_response: true, business_response: false)
      redirect_to person_conversation_url(current_person, conversation), notice: '<span class="text-semibold">Well done!</span> Message has been sent to merchant.'
    end
  end
end
