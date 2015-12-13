FactoryGirl.define do
  factory :answer do
    body 'body answer'  
  end
  factory :invalid_answer, class: 'Answer' do
    body nil
  end  
end
