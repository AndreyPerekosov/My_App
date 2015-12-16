require 'rails_helper'

RSpec.describe Question, type: :model do
  # it 'validates presence of title' do
  #   question = Question.new(body: '123')
  #   expect(question).not_to be_valid # expect - ожидаем значение be_valid автоматический образован от стандартного метода .valid?
  #   #можно not_to и to_not
  # end можно писать проверки так, а можно с помощью shoulda-matchers (см. ниже)
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:title).is_at_most(200) } #описание в данном случае добавляет библиотека добавляет автоматически 
  it { should have_many (:answers) }
  it {should validate_uniqueness_of (:title) }
end
