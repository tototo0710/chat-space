class GroupsController < ApplicationController

  def index
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'グループを作成しました。'
      redirect_to group_messages_path(@group)
    else
      flash[:alert] = 'グループを作成出来ませんでした。'
      render :new
    end
  end

  def edit
    set_group
  end

  def update
    set_group
    if @group.update(group_params)
      flash[:success] = 'グループを編集しました。'
      redirect_to group_messages_path(@group)
    else
      flash[:alert] = 'グループを編集出来ませんでした。'
      render :edit
    end
  end


  private
  def set_group
    @group = Group.find(params[:id])
  end
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end
end
