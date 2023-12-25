class User::ReviewsController < ApplicationController
  # edit,update,destroyアクション前にensure_correct_user実行
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
 # ユーザーと紐付けしてるから誰が投稿したかの情報も一緒に入れてあげる
    @review.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:review][:name].split(',')
  # 保存できたらレビュー詳細へ
    if @review.save
      @review.save_tag(tag_list)
      redirect_to review_path(@review.id), notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def index
    # paramsにtag_nameが含まれているときそのtagがついてるレビューを表示
    if params[:tag_name]
      @tag = Tag.find_by(name: params[:tag_name])
      @reviews = @tag.reviews.order(created_at: :desc).page(params[:page]).per(6)
    else
      @reviews = Review.order(created_at: :desc).page(params[:page]).per(6)
    end
    @tag_list = Tag.all
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
    @review_tags = @review.tags
  end

  def edit
    # pluckはmapと同じ意味
    @tag_list = @review.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:review][:name].split(',')
    if @review.update(review_params)
      @review.save_tag(tag_list)
      redirect_to review_path(@review.id), notice: "投稿内容を変更しました"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_path(@user)
  end

  def search
    @reviews = Review.where(product_id: params[:search][:product]).order(created_at: :desc).page(params[:page]).per(6)
    render :index
  end

  private
  def review_params
    params.require(:review).permit(:user_id, :product_id, :rate, :image, :body)
  end

  # 他人のreview編集画面へのアクセス禁止
  # 勝手に編集、削除しようとする人はTOPページへ行く
  def ensure_correct_user
    @review = Review.find(params[:id])
    @user = current_user
    unless @review.user == @user
      flash[:alert] = "他ユーザーの投稿は編集・削除できません。"
      redirect_to root_path
    end
  end

end
