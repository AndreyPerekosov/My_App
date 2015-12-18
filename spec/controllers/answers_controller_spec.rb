require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:question) {FactoryGirl.create(:question)}
  let (:user) { create(:user) }

  describe "GET #new" do
    before do
      login(user) 
      get :new, question_id: question 
    end
    it 'assigns new Answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'renders new template' do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before { login(user) }
    context 'valid' do
      it 'saves new answer in DB' do
        expect { post :create, question_id: question,
                      answer: FactoryGirl.attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end

    context 'invalid' do
      it 'does not save new answer in DB' do
        expect { post :create, question_id: question,
                      answer: FactoryGirl.attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 'renders new template' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do
    let! (:answer) { create(:answer) }
    context do 'Author'
      before do 
        login(answer.user)
      end
      it 'deletes question from DB if ' do
        expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question show' do
        delete :destroy, id: answer
        expect(response).to redirect_to question_path
      end
    end

    context do 'Non-author'
      before do
        login(user)
      end
      it 'Does not delete answer from DB if ' do
        expect { delete :destroy, id: answer }.to_not change(Answer, :count)
      end

      it 'redirects to question show' do
        delete :destroy, id: answer
        expect(response).to redirect_to question_path
      end 
    end
    end

end
