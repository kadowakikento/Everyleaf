class ChangeDatatypeStatusOfTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :status, :integer, using: "status::integer"
  end
end
