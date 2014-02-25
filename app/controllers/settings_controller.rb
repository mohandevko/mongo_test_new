class SettingsController < ApplicationController
  
  def index
    @users = User.all
  end
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Updation succeed!"
      redirect_to root_path
    else
      flash[:error] = "Updation failed!"
      render :action => :edit
    end
  end
  
  def approve
    @user = User.find(params[:id])
    @user.status = params[:status]
    @user.save(:validate => false)
    @status = @user.status == true ? "Approved" : "Not Approved"
    render
  end
  
  private
  def user_params
    params.require(:user).permit!
  end
end
