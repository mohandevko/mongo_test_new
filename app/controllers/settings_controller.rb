class SettingsController < ApplicationController
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
  
  private
  def user_params
    params.require(:user).permit!
  end
end
