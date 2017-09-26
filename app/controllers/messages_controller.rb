class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @message = Message.new
    @group = current_user.groups.find(params[:group_id])
    @member = @group.users.all
    @messages = Message.where(group_id: params[:group_id])
  end

  def create
    @message = Message.new(message_params)
    @group = current_user.groups.find(params[:group_id])
    @member = @group.users.all
    @messages = Message.where(group_id: params[:group_id])
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path }
        format.json
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
