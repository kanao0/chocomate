class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @product = Product.new
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "登録が完了いたしました"
      redirect_to admin_products_path
    else
    # エラーの場合一覧に戻る
      @products = Product.all
      render :index
    end    
  end  

  def edit
    @product = Product.find(params[:id])    
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "変更が完了いたしました"
    #変更後一覧画面にリダイレクト
      redirect_to admin_products_path
    else
      # エラーの場合編集画面に戻る
      render :edit
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "削除しました"    
    redirect_to  admin_products_path    
  end
  
  
  def product_params
    params.require(:product).permit(:name, :brand_id, :price, :origin_id, :type_id )
  end  
   

end
