require 'rails_helper'
describe Message do
  before do
    @user = create(:user)
    @group = create(:group)
  end
  describe '#message-success01' do
    it "メッセージがあれば保存できる" do
      message = build(:message, image: nil, group_id: @group[:id], user_id: @user[:id])
      expect(message).to be_valid
    end
  end
  describe '#message-success02' do
    it "画像があれば保存できる" do
      message = build(:message, body: nil, group_id: @group[:id], user_id: @user[:id])
      expect(message).to be_valid
    end
  end
  describe '#message-success03' do
    it "メッセージと画像があれば保存できる" do
      message = build(:message, group_id: @group[:id], user_id: @user[:id])
      expect(message).to be_valid
    end
  end
  describe '#message-error01' do
    it "メッセージも画像も無いと保存できない" do
      message = build(:message, body: nil, image: nil, group_id: @group[:id], user_id: @user[:id])
      message.valid?
      expect(message.errors[:body_or_image]).to include("can't be blank")
    end
  end
  describe '#message-error02' do
    it "group_idが無いと保存できない" do
      message = build(:message, group_id: nil, user_id: @user[:id])
      message.valid?
      expect(message.errors[:group]).to include("must exist")
    end
  end
  describe '#message-error03' do
    it "user_idが無いと保存できない" do
      message = build(:message, group_id: @group[:id], user_id: nil)
      message.valid?
      expect(message.errors[:user]).to include("must exist")
    end
  end
end
