require 'rails_helper'

feature 'Signing in', %q{
  In order to be able ask questions
  As an user
  I want to be able to sign in
  } do
    scenario 'Exit user tries to sign in' do
      #готовим данные
      User.create(email: 'user@test.com', password: '12345678')

      visit new_user_session_path #хэлпер библиотеки Device
      fill_in 'Email', with: 'user@test.com'
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
      #save_and_open_screenshot
      click_on 'Log in'

      expect(page).to have_content 'Invalid email or password' #текст ищется по всей странице
      save_and_open_page
      expect(page).to_not have_link 'Log out'
    end
end