class Question < ActiveRecord::Base
  
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, length: { maximum: 200 }
  validates :body, presence: true
  validates :title, uniqueness: true
  validates :user_id, presence: true
  
end
