class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :members

  validate :add_error_name

  def add_error_name
    if name.empty?
      errors[:base] << "グループ名がありません。"
    end
  end
end
