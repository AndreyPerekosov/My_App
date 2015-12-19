require 'rails_helper'

feature 'Edit answer', %q{
  In order to edit an answer
  As author of the answer
  I want to be able to edit the answer
} do 

  given(:user){create :user}
  given(:answer){create :answer}

  scenario 'Author edits the answer' do
    login(answer.user)
    visit question_path(answer.question)
    click_on 'Edit answer'
    fill_in 'Answer', with: 'text, text'
    click_on 'Edit'

    expect(page).to have_content 'Your answer successfully updated'
    expect(page).to have_content 'text, text'
  end
  
  scenario 'Not the author of the answer tries to edit one' do
    login(user)
    visit question_path(answer.question)

    expect(page).to_not have_content 'Edit answer'
  end

  scenario 'Non-authenticated user tries to edit the answer' do
    visit question_path(answer.question)

    expect(page).to_not have_content 'Edit answer'
  end

end