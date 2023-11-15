class User::UsersController < ApplicationController
  # edit,updateアクション前にensure_correct_user実行
  # before_action :ensure_correct_user, only: [:edit, :update]
  # before_action :authenticate_user!, only: [:edit, :update]

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
      redirect_to user_path(@user.id), notice: "ユーザー情報の変更を完了しました"
    else
      render :edit
    end
  end

  def bookmark
    @user = User.find(params[:id])
    @bookmark_reviews = @user.bookmarks
    p @bookmark_reviews
    # @reviews = @user.bookmarks.review
  end

  def quit
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :bio, :is_active, :email, :profile_image)
  end

  # 他人のユーザ情報編集画面にいけないようにするやつ
  # 勝手に編集しようとする人は自分のuser/showページへ行く
  # def ensure_correct_user
  #   @review = Review.find(params[:id])
  #   @user = current_user
  #   unless @review.user == @user
  #     redirect_to user_path(@user)
  #   end
  # end

end
