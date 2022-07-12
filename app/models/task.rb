class Task < ApplicationRecord
  validates :title, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :content, presence: true
  validates :status, presence: true
  enum status:{ 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 低:1, 中:2, 高:3 }
  # scope :, -> { where(:attibute => value)}
  scope :status_title, -> (params) do where("title LIKE ?", "%#{params[:task][:title]}%").where(status: params[:task][:status]) end
  scope :title, -> (params) do where("title LIKE ?", "%#{params[:task][:title]}%") end
  scope :status, -> (params) do where(status: params[:task][:status]) end
end
