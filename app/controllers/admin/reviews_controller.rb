class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all.page(params[:page]).per(3)
    # paramsにtag_nameが含まれているときそのtagがついてるレビューを表示
    # if params[:tag_name]
    #   @tag =Tag.find_by(name: params[:tag_name])
    #   @reviews = @tag.reviews
    # end
    if params[:tag_name]
      @tag = Tag.find_by(name: params[:tag_name])
      @reviews = @tag.reviews.page(params[:page]).per(3)
    else
      @reviews = Review.all.page(params[:page]).per(3)
    end
    # t
    @tag_list = Tag.all    
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
    @review_tags = @review.tags  
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def search
    @reviews = Review.where(product_id: params[:search][:product]).order(created_at: :desc).page(params[:page]).per(3)
    render :index
  end  

end
