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