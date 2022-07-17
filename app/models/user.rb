class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_update :admin_cannot_update
  before_destroy :admin_cannot_delete
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 5 }
  
  private

  def admin_cannot_update
    throw :abort if User.where(admin: true).count == 1 && self.admin_change == [true, false]
  end

  def admin_cannot_delete
    throw :abort if User.where(admin: true).count == 1 && self.admin == true
  end

end
