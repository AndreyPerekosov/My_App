require 'rails_helper'

feature 'Edit question', %q{
  In order to edit a question 
  As author of the question
  I want to be able to edit the question
  } do
  given(:user) {create(:user)}
  given(:question) {create(:question)}

  scenario 'Author edits the question' do
    login(question.user)

    click_on 'Edit question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'text, text'
    click_on 'Edit'

    expect(page).to have_content 'Your question successfully updated'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text, text'
  
  end

  scenario 'Not the author of the question tries edit one' do
    login(user)

    expect(page).to_not have_content 'Edit question' 
  end

  scenario 'Non-authenticated user tries edit the question' do 
    visit questions_path

    expect(page).to_not have_content 'Edit question'
  end

end