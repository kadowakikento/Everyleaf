# テーブルスキーマ

## Userモデル
| カラム名 | データ型 |
| ----- | ----- |
| name |  string  |
| email  | string  |
| password_digest |  string  |
| image |  string  |

## Taskモデル
| カラム名 | データ型 |
| ----- | ----- |
| title |  string  |
| deadline  | datetime  |
| priority |  string  |
| content  | string  |
| status |  string  |

## Labelモデル
| カラム名 | データ型 |
| ----- | ----- |
| name |  string  |

## Intモデル
| カラム名 | データ型 |
| ----- | ----- |
| task_id |  bigint  |
| label_id  | bigint  |

## Herokuへのデプロイ手順
1. ＄heroku login
   - herokuにログインする
2. $ heroku create
   - herokuに新しいアプリを作成
3. $ heroku buildpacks:set heroku/ruby
   - rubyのbuildpackを追加する
4. $ heroku buildpacks:add --index 1 heroku/nodejs
   - node.jsのbuildpackを追加する
5. $ bundle lock --add-platform x86_64-linux
   - x86_64-linuxを追加する
6. $ git add .
   - 変更を追加する
7. $ git commit -m "コミットメッセージ"
   - コミットメッセージを書いてコミットする
8. $ git push heroku (ブランチ名):master
   - Pushしてデプロイする