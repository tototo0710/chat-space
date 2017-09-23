require 'rails_helper'
describe Message do
  describe '#message-success01' do
    it "メッセージがあれば保存できる" do
      message = build(:message, image: nil)
      expect(message).to be_valid
    end
  end
  describe '#message-success02' do
    it "画像があれば保存できる" do
      message = build(:message, body: nil)
      expect(message).to be_valid
    end
  end
  describe '#message-success03' do
    it "メッセージと画像があれば保存できる" do
      message = build(:message)
      expect(message).to be_valid
    end
  end
  describe '#message-error01' do
    it "メッセージも画像も無いと保存できない" do
      message = build(:message, body: nil, image: nil)
      message.valid?
      expect(message.errors[:body_or_image]).to include("can't be blank")
    end
  end
  describe '#message-error02' do
    it "group_idが無いと保存できない" do
      message = build(:message, group_id: nil)
      message.valid?
      expect(message.errors[:group]).to include("入力してください")
    end
  end
  describe '#message-error03' do
    it "user_idが無いと保存できない" do
      message = build(:message, user_id: nil)
      message.valid?
      expect(message.errors[:user]).to include("入力してください")
    end
  end
end
