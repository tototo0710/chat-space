class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :members

  validate :add_error_name

  def add_error_name
    errors[:base] << "グループ名がありません。" if name.empty?
  end
end
