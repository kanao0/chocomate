class Admin::OriginsController < ApplicationController

  def index
    @origin = Origin.new
    @origins = Origin.all
  end
  
  def create
    @origin = Origin.new(origin_params)
    if @origin.save
      flash[:notice] = "登録が完了いたしました"
      redirect_to admin_origins_path
    else
    # エラーの場合一覧に戻る
      @origins = Origin.all
      render :index
    end    
  end  

  def edit
    @origin = Origin.find(params[:id])    
  end
  
  def update
    @origin = Origin.find(params[:id])
    if @origin.update(origin_params)
      flash[:notice] = "変更が完了いたしました"
    #変更後一覧画面にリダイレクト
      redirect_to admin_origins_path
    else
      # エラーの場合編集画面に戻る
      render :edit
    end
  end
  
  def destroy
    @origin = Origin.find(params[:id])
    @origin.destroy
    flash[:notice] = "削除しました"    
    redirect_to  admin_origins_path    
  end
  
  
  def origin_params
    params.require(:origin).permit(:name)
  end  
  
end
