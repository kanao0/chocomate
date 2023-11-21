class User::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

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

  def bookmarks
    @user = User.find(current_user.id)
    @bookmark_reviews = @user.bookmarks.page(params[:page]).per(10)
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
  def ensure_correct_user
    @user = User.find(params[:id])
    unless  @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  # ゲストユーザーはユーザ情報編集画面に遷移できない
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
