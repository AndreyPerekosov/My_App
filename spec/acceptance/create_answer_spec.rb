require 'rails_helper'

feature 'Write answer', %q{
In order to write an answer the question
As authenticated user
I want to be able to write an answer
} do
  given!(:user) {create (:user)}
  given!(:question) {create (:question)}  
  scenario 'Authenticated user write an answer', js: true do
    login(user) 
    visit question_path(question)
    # click_on 'Answer the question'
    fill_in 'Answer', with: 'text, text'
    click_on 'Create'

    #check
    expect(page).to have_content 'Your answer successfully created'
    within '.answers' do #селектор within позволяет выбирать определенные области. Здесь при помощи html-класса .answers
      expect(page).to have_content 'text, text'
    end 
  end
  
  scenario 'Non-authenticated user tries to write an answer' do 

    visit question_path(question)
    expect(page).to_not have_content "New answer"
  end

end