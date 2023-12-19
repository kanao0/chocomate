# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'レビューを見るリンクが表示される: 左上から1番目のリンクが「レビューを見る」である' do
        review_link = find_all('.nav-item a')[0]
        expect(review_link.text).to match(/レビューを見る/)  
        expect(review_link["href"]).to match("/reviews")
      end

      it 'ゲストログインリンクが表示される: 左上から2番目のリンクが「ゲストログイン」である' do
        guest_login_link = find_all('.nav-item a')[1]
        expect(guest_login_link.text).to match(/ゲストログイン/)
        expect(guest_login_link["href"]).to match("/user/guest_sign_in")
      end

      it 'ログインリンクが表示される: 左上から3番目のリンクが「ログイン」である' do
        login_link = find_all('.nav-item a')[2]
        expect(login_link.text).to match(/ログイン/)
        expect(login_link["href"]).to match("/users/sign_in")  
      end

      it '新規登録リンクが表示される: 左上から4番目のリンクが「新規登録」である' do
        signup_link = find_all('.nav-item a')[3]
        expect(signup_link.text).to match(/新規登録/)
        expect(signup_link["href"]).to match("/users/sign_up")      
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Chocomateを押すと、トップ画面に遷移する' do
        # href属性の値を検証
          home_link = find_all('.navbar-brand')[0]["href"]
          expect(home_link).to eq("/")
      end
    end
  end
end
