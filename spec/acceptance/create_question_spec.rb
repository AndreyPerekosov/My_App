require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be abel to ask question
} do
  
  given!(:user) {create (:user)} 
  
  scenario 'Authenticated user create a question' do
    
    # visit new_user_session_path 
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: '12345678'
    # click_on 'Log in' -> выносим это в хелпер
    login(user)

    visit questions_path # переход на список вопросов
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
    #проверяем, что тело и заголовок есть на странице, ищем просто как текст
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text'
  end

  scenario 'Non-authenticated user tries to create a question' do
    visit questions_path

    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end