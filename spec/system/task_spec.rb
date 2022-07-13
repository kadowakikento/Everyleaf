require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title',	with: '会食'
        fill_in 'task_content', with: '〇〇さんと会食'
        fill_in 'task_deadline',  with: Date.today
        find("#task_status").find("option[value='未着手']").select_option
        find("#task_priority").find("option[value='中']").select_option
        click_button '登録する'
        expect(page).to have_content '会食'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中') 
        visit tasks_path
        expect(page).to have_content '会食1'
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      task = FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
      second_task = FactoryBot.create(:second_task, title: '会食2', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
      visit tasks_path
      task_list = all('.task_row')
      expect(task_list[0]).to have_content '会食2'
      expect(task_list[1]).to have_content '会食1'
    end
  end
  context '終了期限でソートした場合' do
    it '終了期限の降順で表示される' do
      task = FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
      second_task = FactoryBot.create(:second_task, title: '会食2', content: '〇〇さんと会食', deadline: '2022-07-15', status: '未着手', priority: '中')
      visit tasks_path
      task_list = all('.task_row')
      expect(task_list[0]).to have_content '会食2'
      expect(task_list[1]).to have_content '会食1'
    end 
  end
  context '優先順位でソートした場合' do
    it '優先順位の高い順で表示される' do
      task = FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
      second_task = FactoryBot.create(:second_task, title: '会食2', content: '〇〇さんと会食', deadline: '2022-07-15', status: '未着手', priority: '高')
      visit tasks_path
      task_list = all('.task_row')
      expect(task_list[0]).to have_content '会食2'
      expect(task_list[1]).to have_content '会食1'
    end 
  end
end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
        visit tasks_path
        click_link '詳細'
        expect(page).to have_content '会食1'
      end
    end
  end
  describe '検索機能' do
    before do
      task = FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中')
      second_task = FactoryBot.create(:second_task, title: '会食2', content: '〇〇さんと会食', deadline: '2022-07-15', status: '未着手', priority: '中')
      visit tasks_path
    end

    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        visit tasks_path
        fill_in 'task_title', with: '会食1'
        click_button '検索'
        expect(page).to have_content '会食1'
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        find("#task_status").find("option[value='未着手']").select_option
        click_button '検索'
        expect(page).to have_content '会食1'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        fill_in 'task_title', with: '会食1'
        find("#task_status").find("option[value='未着手']").select_option
        click_button '検索'
        expect(page).to have_content '会食1'
      end
    end
  end
end