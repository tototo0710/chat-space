class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :members
  has_many :messages

  validate :add_error_name

  def add_error_name
    errors[:base] << "グループ名がありません。" if name.empty?
  end
  def permit
     if messages.last.try(:body).present?
        messages.last.body
     elsif messages.last.try(:image).present?
        "画像が投稿されました"
     else
        "メッセージがありません"
     end
  end

end
