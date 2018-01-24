class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :talks

  def latest_messages(group)
    if group.talks.last.try(:message).present?
      group.talks.last.try(:message)
    else
      "まだメッセージがありません。"
    end
  end
end
