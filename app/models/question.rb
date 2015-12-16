class Question < ActiveRecord::Base
  
  has_many :answers, dependent: :destroy

  validates :title, length: { maximum: 200 }
  validates :body, presence: true
  validates :title, uniqueness: true
  
end
