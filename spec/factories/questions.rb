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
end
