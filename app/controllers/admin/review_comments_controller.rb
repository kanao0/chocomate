class Admin::ReviewCommentsController < ApplicationController
  def destroy
    @review = Review.find(params[:review_id])
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy
    # redirect_to admin_review_path(@review)
  end
end
