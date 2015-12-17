require 'rails_helper'

feature 'Delete question', %q{
In order to delete question
As authenticated user
I want to be able to delete a question
} do
  
  given!(:user) {create (:user)}
  given!(:question) {create (:question)}
  #можно еще так given(:question) {create(:question, user: user)}
  
  scenario 'Non-author of question tries to delete the question' do
    login(user)

    #check  
    expect(page).to_not have_content 'Delete question' 

  end

  scenario 'Author of question deletes the question' do 
    login(question.user)
    click_on 'Delete question'

    #check  
    expect(page).to have_content 'Your question delete!'
    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
  end

  scenario 'Non-authenticated user tries to delete the question' do 
    visit questions_path

    #check  
    expect(page).to_not have_content 'Delete question' 

   end     

end