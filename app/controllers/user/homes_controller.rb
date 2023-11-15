class User::HomesController < ApplicationController
  # 最新レビュー4つ表示
  def top
    @reviews = Review.order('id DESC').limit(4)
  end
end
