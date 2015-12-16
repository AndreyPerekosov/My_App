FactoryGirl.define do
  sequence :title do |n|
    "My question_#{n}"
  end
  factory :question do
    title 
    body 'question body'
  end
  factory :invalid_question, class: 'Question' do #создаем невалидный объект
    title nil
    body nil
  end

  factory :question_with_answers, class: 'Question' do 
    title
    body 'question body'
    transient do
      answers_count 3
    end
  end 
end
