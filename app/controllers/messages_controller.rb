class MessagesController < ApplicationController
  def index
    @message = Message.new
    @group = current_user.groups.find(params[:group_id])
    @member = @group.users.all
    @messages = Message.where(group_id: params[:group_id])
  end

  def create
    @message = Message.new(body: message_params[:body], image: message_params[:image], group_id: params[:group_id], user_id: current_user.id,)
    if @message.save
      redirect_to group_messages_path
    else
      flash[:alert] = 'メッセージを入力してください。'
      redirect_to group_messages_path
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache)
  end
end
