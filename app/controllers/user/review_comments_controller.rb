class User::ReviewCommentsController < ApplicationController
  # destroyアクション前にensure_correct_user実行
  before_action :ensure_correct_user, only: [:destroy]
  before_action :authenticate_user!, only: [:destroy]

  def create
    @review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = @review.id
    comment.save

  end


  def destroy
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy

  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end

  # 他人のreview編集画面へのアクセス禁止
  # 勝手に編集、削除しようとする人はTOPページへ行く
  def ensure_correct_user
    @review = Review.find(params[:review_id])
    @user = current_user
    unless @review.user == @user
      flash[:alert] = "他ユーザーのコメントは削除できません。"
      redirect_to root_path
    end
  end
end
