require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:question) {FactoryGirl.create(:question)}
  let (:user) { create(:user) }
  let! (:answer) { create(:answer) }

  describe "GET #new" do
    before do
      login(user) 
      get :new, question_id: question 
    end
    it 'assigns new Answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    # it 'renders new template' do
    #   expect(response).to render_template :new
    # end
  end

  describe "POST #create" do
    before { login(user) }
    context 'valid' do
      it 'saves new answer in DB' do
        # add format: :js for rspec test, becouse we render responce in js (ajax)
        expect { post :create, question_id: question, format: :js,
                      answer: FactoryGirl.attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end
      
      it 'renders js template create' do
        post :create, question_id: question, format: :js, answer: FactoryGirl.attributes_for(:answer)
        expect(response).to render_template :create #render template js
      end
    end

    context 'invalid' do
      it 'does not save new answer in DB' do
        expect { post :create, question_id: question, format: :js,
                      answer: FactoryGirl.attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end
      it 'renders js template create' do
        post :create, question_id: question, format: :js, answer: FactoryGirl.attributes_for(:invalid_answer)
        expect(response).to render_template :create #render template js
      end 
    end
  end

  describe "DELETE #destroy" do
    context do 'Author'
      before do 
        login(answer.user)
      end
      it 'deletes question from DB if ' do
        expect { delete :destroy, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end
      
      it 'renders js template destroy' do
        delete :destroy, id: answer, format: :js
        expect(response).to render_template :destroy #render template js
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

  describe 'GET #edit' do
    context  do 'Author'
      before do
        login(answer.user)
        get :edit, id: answer
      end
      it 'assigns edit answer' do
        expect(assigns(:answer)).to eq answer    
      end
      it 'renders edit template' do
        expect(response).to render_template :edit    
      end
    end

    context do 'Non-author'
      it 'redirects to question show' do
        login(user)
        get :edit, id: answer
        expect(response).to redirect_to question_path(answer.question)   
      end
    end
  end

  describe 'PATCH #update' do 
    context 'Author' do
      before do
        login(answer.user)
        patch :update, id: answer, answer:{ body: 'new body' } 
      end
      it 'changes an answer' do
        answer.reload
        expect(answer.body).to eq 'new body'   
      end
      it 'redirects to question show' do
        expect(response).to redirect_to question_path(answer.question) 
      end
    end

    context 'Non-author' do
      before do
        login(user)
        patch :update, id: answer, answer:{ body: 'new body' } 
      end
      it 'does not change an answer' do
        answer.reload
        expect(answer.body).to_not eq 'new body'   
      end
      it 'redirects to question show' do
        expect(response).to redirect_to question_path(answer.question) 
      end
    end

    context 'invalid answer' do
      before do
        login(answer.user)
        patch :update, id: answer, answer:{ body: nil } 
      end
      it 'does not change an answer' do
        answer.reload
        expect(answer.body).to_not eq ''   
      end
      it 'renders edit template' do
        expect(response).to render_template :edit
      end
    end
  end

end
