class Admin::TypesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @type = Type.new
    @types = Type.all
  end
  
  def create
    @type = Type.new(type_params)
    if @type.save
      flash[:notice] = "登録が完了いたしました"
      redirect_to admin_types_path
    else
    # エラーの場合一覧に戻る
      @types = Type.all
      render :index
    end    
  end  

  def edit
    @type = Type.find(params[:id])    
  end
  
  def update
    @type = Type.find(params[:id])
    if @type.update(type_params)
      flash[:notice] = "変更が完了いたしました"
    #変更後一覧画面にリダイレクト
      redirect_to admin_types_path
    else
      # エラーの場合編集画面に戻る
      render :edit
    end
  end
  
  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    flash[:notice] = "削除しました"    
    redirect_to  admin_types_path    
  end
  
  
  def type_params
    params.require(:type).permit(:name)
  end  
end
