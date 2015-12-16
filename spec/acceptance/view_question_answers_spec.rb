require 'rails_helper'

feature 'View question answers', %q{
In order to see list of questions
As an non-authenticated user
I want to be abel to see all questions
} do
    given!(:question) {create (:question_with_answers)}
  scenario 'Non-authenticated user looks at the list of question answers' do
    
    visit question_path(question)
    
    #check   
    expect(current_path).to eq question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end 

end