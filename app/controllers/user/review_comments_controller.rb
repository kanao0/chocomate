class User::ReviewCommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = @review.id
    comment.save
    # redirect_to review_path(review)
  end


  def destroy
    @review = Review.find(params[:review_id])
    @review_comment = ReviewComment.find(params[:id])
    @user = current_user
    @review_comment.destroy
    # redirect_to review_path(review)
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end
end
