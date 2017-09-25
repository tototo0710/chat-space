require 'rails_helper'
describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { create(:message) }
  describe 'GET #index' do
    context 'ログイン状態' do
      before do
        login_user user
        @group = user.groups.first
        get :index, params: { group_id: @group.id }
      end
      it "indexのビューを描画" do
        expect(response).to render_template :index
      end
      context "インスタンス変数の確認" do
        example "@message" do
          expect(assigns(:message)).to be_a_new(Message)
        end
        example "@group" do
          group = user.groups.find(@group)
          expect(assigns(:group)).to eq group
        end
        example "@member" do
          group = user.groups.find(@group)
          member = group.users.all
          expect(assigns(:member)).to eq member
        end
        example "@messages" do
          messages = @group.messages.where(group_id: @group.id)
          expect(assigns(:messages)).to eq messages
        end
      end
    end
    context "ログインしていない状態" do
      it "意図したビューにリダイレクトできているか" do
        @group = user.groups.first
        get :index, params: { group_id: @group.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'ログイン状態' do
      before do
        login_user user
        @group = user.groups.first
      end
      context 'ログインしているかつ、保存に成功した場合' do
        subject {
          post :create,
          params: {group_id: @group, message: attributes_for(:message)}
        }
        example "メッセージの保存はできたのか" do
          expect{subject}.to change(Message, :count).by(1)
        end
        example "意図した画面に遷移しているか" do
          expect(subject).to redirect_to(group_messages_path)
        end
      end
      context 'ログインしているが、保存に失敗した場合' do
        subject {
          post :create,
          params: {group_id: @group, message: attributes_for(:message, body: nil, image: nil)}
        }
        example "メッセージの保存は行われなかったか" do
          expect{subject}.not_to change(Message, :count)
        end
        example "意図したビューが描画されているか" do
          expect(subject).to render_template :index
        end
      end
    end
    context 'ログインしていない状態' do
      it "ログインしていない場合に意図した画面にリダイレクトできているか" do
        @group = user.groups.first
        post :create, params: {group_id: @group, message: attributes_for(:message)}
        expect(subject).to redirect_to(new_user_session_path)
      end
    end
  end
end
