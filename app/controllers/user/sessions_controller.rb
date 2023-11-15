# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # ログイン機能のコントローラー
  before_action :user_state, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "guestuserでログインしました。"
  end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
  # 退会しているかを判断するメソッド
  def user_state
    # 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    if @user
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @user.valid_password?(params[:user][:password]) && !@user.is_active
      #一致してるかつ退会してたら（!〇〇.is_active=有効状態の反転）
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
          flash[:notice] = "項目を入力してください"
      end
    end

  end

end
