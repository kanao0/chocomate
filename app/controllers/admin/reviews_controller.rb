class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:tag_name]
      @tag = Tag.find_by(name: params[:tag_name])
      @reviews = @tag.reviews.page(params[:page]).per(6)
    else
      @reviews = Review.all.page(params[:page]).per(6)
    end
    # t
    @tag_list = Tag.all
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
    @review_tags = @review.tags
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "ユーザーの投稿を削除しました"
    redirect_to admin_reviews_path
  end

  def search
    @reviews = Review.where(product_id: params[:search][:product]).order(created_at: :desc).page(params[:page]).per(6)
    render :index
  end
  
end
