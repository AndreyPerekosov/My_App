class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  
  validates :body, presence: true
  validates :body, uniqueness: true  

  validates :question_id, presence: true
  validates :user_id, presence: true
 
end
