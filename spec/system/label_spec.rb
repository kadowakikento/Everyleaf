require 'rails_helper'
RSpec.describe 'ラベル機能のテスト', type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:third_label) { FactoryBot.create(:third_label) }

  before do 
    visit new_session_path
    fill_in 'session_email', with: 'test@test.com'
    fill_in 'session_password', with: '12345678'
    click_button 'ログイン'
  end

  describe 'ラベル管理' do 
    before do
      visit new_task_path
      fill_in 'task_title',	with: 'test'
      fill_in 'task_content', with: 'test'
      fill_in 'task_deadline',  with: Date.today
      find("#task_status").find("option[value='未着手']").select_option
      find("#task_priority").find("option[value='中']").select_option
      check 'test_01'
      check 'test_02'
      click_button '登録する'
    end
    context 'タスクを新規作成した時に' do
      it 'タスクに複数のラベルが表示される' do
        expect(page).to have_content 'test_01'
        expect(page).to have_content 'test_02'
      end
    end
    context 'タスクの詳細画面に移った時に' do
      it 'そのタスクに紐づいているラベルが出力される' do
        visit tasks_path
        click_link '詳細', match: :first 
        expect(page).to have_content 'test_01'
      end
    end
    context 'タスクを編集した時に' do
      it 'タスクに紐づいているラベルも一緒に編集ができる' do
        click_link '編集', match: :first
        fill_in 'task_title',	with: 'test'
        fill_in 'task_content', with: 'test'
        fill_in 'task_deadline',  with: Date.today
        find("#task_status").find("option[value='完了']").select_option
        find("#task_priority").find("option[value='低']").select_option
        check 'test_03'
        click_on '更新する'
        expect(page).to have_content 'test_03'
      end
    end 
    context 'ラベルを検索した時に' do
      it 'つけたラベルに一致する' do
        visit tasks_path
        select 'test_01'
        click_on '検索'
        expect(page).to have_content 'test_01'
      end
    end
  end 
end 
