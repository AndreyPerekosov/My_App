FactoryGirl.define do
  sequence :email do |n| #делаем парочку пользователей
    "user_#{n}@test.com"
  end
  factory :user do
    email #здесь с помощью sequence подставляется уникальное имя пользователя 
    password '12345678'
    password_confirmation '12345678'#подтверждение пароля
  end

end
