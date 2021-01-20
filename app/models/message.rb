class Message < ApplicationRecord
  belongs_to :conversation

  validates_presence_of :remark, :content

  # def message_time
  #   created_at.strftime(“%m/%d/%y at %l:%M %p”)
  # end
end
