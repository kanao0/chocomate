class User::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    @review = @bookmark.review
    if @bookmark.valid?
      @bookmark.save
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @review = @bookmark.review
    @bookmark.destroy
  end

  private

  def bookmark_params
    params.permit(:review_id)
  end

end
