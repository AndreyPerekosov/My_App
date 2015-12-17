require 'rails_helper'

feature 'Delete question', %q{
In order to delete question
As authenticated user
I want to be able to delete a question
} do
  
  given!(:user) {create (:user)}
  given!(:question) {create (:question)}
  scenario 'Non-author of question tries to delete the question' do
    login(user)
    click_on 'Delete question'

    #check  
    expect(page).to have_content 'Only author can delete question!' 

  end

   scenario 'Author of question deletes the question' do 
    login(question.user)
    click_on 'Delete question'

    #check  
    expect(page).to have_content 'Your question delete!'
   end 
    
  


end