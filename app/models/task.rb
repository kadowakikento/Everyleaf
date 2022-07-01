class Task < ApplicationRecord
  validates :title, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :content, presence: true
end
