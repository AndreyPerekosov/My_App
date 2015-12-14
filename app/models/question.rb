class Question < ActiveRecord::Base
  validates :title, length: { maximum: 200 }
  validates :body, presence: true
  has_many :answers, dependent: :destroy
end
