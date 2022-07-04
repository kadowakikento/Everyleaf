require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title',	with: '会食'
        fill_in 'task_content', with: '〇〇さんと会食'
        fill_in 'task_deadline',  with: '2022-07-14'
        find("#task_status").find("option[value='未着手']").select_option
        find("#task_priority").find("option[value='中']").select_option
        click_button '登録する'
        click_link '投稿一覧に戻る'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: '会食', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
        visit tasks_path
        expect(page).to have_content '会食'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do

      end
    end
  end
end