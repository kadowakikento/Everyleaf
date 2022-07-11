class Task < ApplicationRecord
  validates :title, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :content, presence: true
  validates :status, presence: true
  enum status:{ 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 低:1, 中:2, 高:3 }
  # scope :name, -> { where(:attibute => value)}
  # Ex:- scope :active, -> {where(:active => true)}
end
