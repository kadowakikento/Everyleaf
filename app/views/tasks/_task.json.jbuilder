json.extract! task, :id, :title, :deadline, :priority, :content, :created_at, :updated_at
json.url task_url(task, format: :json)
