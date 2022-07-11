class ChangeDatatypePriorityOfTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :priority, :integer, using: "priority::integer"
  end
end
