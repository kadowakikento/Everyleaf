require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '', content: '失敗テスト', deadline: '2022-07-14', status: '未着手', priority: '中')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '', deadline: '2022-07-14', status: '未着手', priority: '中')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', deadline: '2022-07-14', status: '未着手', priority: '中')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) {FactoryBot.create(:task, title: '会食1', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中') }
    let!(:second_task) {FactoryBot.create(:second_task, title: '会食2', content: '〇〇さんと会食', deadline: '2022-07-14', status: '未着手', priority: '中') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.title('task')).to include(task)
        expect(Task.title('task')).not_to include(second_task)
        expect(Task.title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        # ここに内容を記載する
        expect(Task.status('未着手')).to include(task)
        expect(Task.status('未着手')).not_to include(second_task)
        expect(Task.status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        # ここに内容を記載する
        expect(Task.status('未着手')).to include(task)
        expect(Task.status('未着手')).not_to include(second_task)
        expect(Task.status('未着手').count).to eq 1
      end
    end
  end
end