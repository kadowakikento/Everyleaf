require 'rails_helper'

RSpec.describe 'ユーザー登録・セッション機能・管理画面のテスト', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーが登録がなく、ログインしていない場合' do
      it 'ユーザーが新規登録をすれば、詳細画面に移動する' do
        visit new_user_path
        fill_in 'user_name', with: 'test_name'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on 'ユーザー登録'
        expect(page).to have_content 'test_name'
      end
    end
    context 'ユーザーがログインせずにタスク一覧へ飛んだとき' do
      it '​ログイン画面に遷移する​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end 
    end
  end
  describe 'セッション機能のテスト' do 
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
    end
    context 'アカウント登録済みのユーザがログインしようとした場合' do
      it 'ログインできる' do
        visit new_session_path
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        expect(current_path).to eq user_path(@user)
      end
      it '自分の詳細画面に飛べること' do
        visit new_session_path
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        expect(current_path).to eq user_path(@user)
      end 

      it '一般ユーザーが他人の詳細画面に飛ぶと、タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit user_path(@second_user)
        expect(current_path).to eq tasks_path
      end
    
      it 'ログアウトができる' do
        visit new_session_path
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit user_path(@user)
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end 
  end
  describe '管理画面のテスト' do
    before do
      @second_user = FactoryBot.create(:second_user)
      @user = FactoryBot.create(:user)
    end
    context '管理ユーザが管理画面にアクセスしようとするとき' do
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'session_email', with: 'second@second.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content 'second@second.com'
      end
    end
    context '一般ユーザが管理画面にアクセスしようとするとき' do
      it '自分のタスクを表示させる' do
        visit new_session_path
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
    context '管理ユーザーがユーザー登録した場合' do
      it 'ユーザーの登録ができる' do
        visit new_session_path
        fill_in 'session_email', with: 'second@second.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit new_admin_user_path
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test_user@user.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_button 'ユーザー登録'
        visit admin_users_path
        expect(page).to have_content 'test_user'
      end
    end
    context '管理ユーザーがユーザーの詳細にアクセスした場合' do
      it 'ユーザーの詳細画面にアクセスできる' do
        visit new_session_path
        fill_in 'session_email', with: 'second@second.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit admin_users_path
        visit user_path(0) 
        expect(current_path).to eq user_path(0)
      end 
    end
    context '管理ユーザーがユーザーの編集画面にアクセスした場合' do
      it 'ユーザーの編集ができる' do
        visit new_session_path
        fill_in 'session_email', with: 'second@second.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit edit_admin_user_path(0)
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_button 'ユーザー登録'
        expect(page).to have_content 'second@second.com'
      end
    end
    context '管理ユーザーがユーザーを削除した場合' do
      it 'ユーザーの削除ができる' do
        visit new_session_path
        fill_in 'session_email', with: 'second@second.com'
        fill_in 'session_password', with: '12345678'
        click_button 'ログイン'
        visit admin_users_path
        page.accept_confirm do
          first(".btn-outline-danger").click
        end
        expect(page).not_to have_content 'test@test.com'
      end
    end  
  end
end