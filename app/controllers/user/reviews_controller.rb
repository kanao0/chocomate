class User::ReviewsController < ApplicationController
  # edit,updateアクション前にensure_correct_user実行
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
 # ユーザーと紐付けしてるから誰が投稿したかの情報も一緒に入れてあげる
    @review.user_id = current_user.id
  # 保存できたらレビュー詳細へ
    if @review.save
      redirect_to review_path(@review.id), notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review.id), notice: "投稿内容を変更しました"
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @user = current_user
    @review.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_path(@user)
  end

  private
  def review_params
    params.require(:review).permit(:user_id, :product_id, :rate, :image, :body)
  end

  # 他人のreview編集画面へのアクセス禁止
  # 勝手に編集しようとする人は自分のuser/showページへ行く
  def ensure_correct_user
    @review = Review.find(params[:id])
    @user = current_user
    unless @review.user == @user
      redirect_to user_path(@user)
    end
  end

end
