require 'rails_helper'

feature 'Signing in', %q{
  In order to be able ask questions
  As an user
  I want to be able to sign in
  } do
    #given!(:user) {FactoryGirl.create (:user)} #аналог let. given! означает, что user будет создан еще до первого вызова и нам не нужно писать специально user
    given!(:user) {create (:user)} # можно так записать, т.к. включили в rails_helper config.include FactoryGirl::Syntax::Methods
    scenario 'Existing user tries to sign in' do
      #готовим данные
      #User.create(email: 'user@test.com', password: '12345678') вместо этой записи, здесь также с помощью FactoryGirl генерим пользователя

      visit new_user_session_path #хэлпер библиотеки Device переходим на страницу аунтетификации
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '12345678'
      #save_and_open_page #- команда позволяет посмотреть страницу
      click_on 'Log in'
      #проверки
      expect(page).to have_content 'Signed in successfully'
      expect(page).to have_link 'Log out'

    end
    scenario 'Non-existing user tries sign in' do
      visit new_user_session_path #хэлпер библиотеки Device
      fill_in 'Email', with: 'wrong@test.com'
      fill_in 'Password', with: 'wrong'
      #save_and_open_screenshot отличие от save_and_open_page - подгружает также css стили  
      click_on 'Log in'

      expect(page).to have_content 'Invalid email or password' #текст ищется по всей странице
      expect(page).to_not have_link 'Log out'
    end
end