require 'rails_helper'

feature 'View question answers', %q{
In order to see list of questions
As an non-authenticated user
I want to be abel to see all questions
} do
  given!(:question) {create (:question)}
  given!(:answers) {build_list(:answer, 3)}
  scenario 'Non-authenticated user looks at the list of question answers' do
    answers.each do |answer|
      question.answers << answer
    end  
    
    visit question_path(question)
    
    #check   
    expect(current_path).to eq question_path(question)
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end 

end