class User::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "変更が完了しました"
    else
      render :edit
    end    
  end

  def quit
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end    


  private

  def user_params
    params.require(:user).permit(:name, :bio, :is_active, :email, :profile_image)
  end

end
