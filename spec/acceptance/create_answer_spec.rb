require 'rails_helper'

feature 'Write answer', %q{
In order to write an answer the question
As authenticated user
I want to be able to write an answer
} do
  given!(:user) {create (:user)}
  given!(:question) {create (:question)}  
  scenario 'Authenticated user write an answer' do
    login(user) 
    visit question_path(question)
    click_on 'Answer the question'
    fill_in 'Answer', with: 'text, text'
    click_on 'Create'

    #check
    expect(page).to have_content 'Your answer successfully created'
    expect(page).to have_content 'text, text'
  end
  
  scenario 'Non-authenticated user tries to write an answer' do 

    visit question_path(question)
    click_on 'Answer the question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end

end