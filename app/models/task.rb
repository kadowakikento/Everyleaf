class Task < ApplicationRecord
  validates :title, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :content, presence: true
  validates :status, presence: true
  enum status:{ 未着手:1, 着手中:2, 完了:3 }
end
