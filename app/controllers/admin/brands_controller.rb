class Admin::BrandsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @brand = Brand.new
    @brands = Brand.all
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:notice] = "登録が完了いたしました"
      redirect_to admin_brands_path
    else
    # エラーの場合一覧に戻る
      @brands = Brand.all
      render :index
    end

  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      flash[:notice] = "変更が完了いたしました"
    # 変更後一覧画面にリダイレクト
      redirect_to admin_brands_path
    else
      # エラーの場合編集画面に戻る
      render :edit
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    flash[:notice] = "削除しました"
    redirect_to  admin_brands_path
  end


  def brand_params
    params.require(:brand).permit(:name)
  end
end
