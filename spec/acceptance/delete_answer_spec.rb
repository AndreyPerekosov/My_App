require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As authenticated user
  I want to be able to delete a question
} do
  given(:user) {create(:user)}
  given(:answer) {create(:answer)}
  scenario 'Author of answer delete one' do
    login(answer.user)
    visit question_path(answer.question)
    click_on 'Delete answer'

    #check  
    expect(page).to have_content 'Your answer delete!'
    expect(page).to_not have_content answer.body
  end

  scenario 'Not the author tries to delete answer' do
    login(user)
    visit question_path(answer.question)

    expect(page).to_not have_content 'Delete answer' 
  end 

  scenario 'Non-authenticated user tries to delete answer' do 
    visit questions_path

    #check
    expect(page).to_not have_content 'Delete answer'
  end

end