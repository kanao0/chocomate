class User::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    @review = @bookmark.review
    if @bookmark.valid?
      @bookmark.save
      redirect_to review_path(@review), notice: "ブックマーク登録しました"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @review = @bookmark.review
    if @bookmark.destroy
      redirect_to review_path(@review), notice: "ブックマークを解除しました"
    end
  end

  private

  def bookmark_params
    params.permit(:review_id)
  end

end
