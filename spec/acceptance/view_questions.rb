require 'rails_helper'

feature 'View questions', %q{
In order to see list of questions
As an non-authenticated user
I want to be abel to see all questions
} do
  given!(:questions) {create_list(:question, 3)}
  scenario 'Non-authenticated user looks at the list of questions' do
    visit questions_path
    
    #check   
    expect(current_path).to eq questions_path
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end 

end