class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :title, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :content, presence: true
  validates :status, presence: true
  enum status:{ 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 低:1, 中:2, 高:3 }
  scope :status_title, -> (params) do where("title LIKE ?", "%#{params[:task][:title]}%").where(status: params[:task][:status]) end
  scope :title, -> (title) do where("title LIKE ?", "%#{title}%") end
  scope :status, -> (status) do where(status: status) end
end
