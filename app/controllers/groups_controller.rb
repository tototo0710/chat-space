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
      redirect_to controller: 'messages', action: 'index'
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = 'グループを編集しました。'
      redirect_to controller: 'messages', action: 'index'
    else
      render 'edit'
    end
  end


  private
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end
end
