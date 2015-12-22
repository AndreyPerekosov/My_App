require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryGirl.create(:question) } #создает метод возвращающий объект вопроса
  let (:user) { create(:user) } #выносим создание user подключили штатный хелпер, по этому FactoryGirl не пишем

  describe "GET #index" do
    before { get :index } #перед каждым it осуществляется вызов метода get контроллера

    it 'loads all questions' do
      questions = FactoryGirl.create_list(:question, 3)
      expect(assigns(:questions)).to eq questions
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: question }

    it 'loads question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before do 
      login(user) #вызываем наш хелпер
    #   @request.env['devise.mapping'] = Devise.mappings[:user] #указываем Devise, что нужно работать с моделью User
    #   sign_in @user -> выносим данный текст в хелпер
      get :new 
    end
    it 'assigns new Question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new template' do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before do
      login(question.user) 
      get :edit, id: question
    end

    it 'assigns edit question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit template' do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    before{ login(user) }
    context 'valid' do
      it 'saves new question in DB' do
        expect { post :create,
                      question: FactoryGirl.attributes_for(:question) }.to change(user.questions, :count).by(1)
      end

      it 'redirects to show' do
        post :create,
             question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid' do
      it 'does not save new question in DB' do
        expect { post :create,
                      question: FactoryGirl.attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'renders show template' do
        post :create,
             question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context 'Author' do
      before do login(question.user) 
        patch :update, id: question, format: :js, question: { title: 'new title', body: 'new body' }
      end
      it 'changes question' do
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'renders js template update' do
        expect(response).to render_template :update
      end
    end

    context 'Author & invalid question' do
      before do 
        login(question.user)
        patch :update, id: question, format: :js, question: { title: nil, body: nil }
      end

      it 'does not change question' do
        question.reload
        expect(question.title).to_not eq nil
        expect(question.body).to_not eq nil
      end

      it 'renders js template update' do
        expect(response).to render_template :update
      end
    end
    
     context 'Non-author' do
      before do 
        login(user)
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
      end

      it 'does not change question' do
        question.reload
        expect(question.title).to_not eq 'new title'
        expect(question.body).to_not eq 'new body'
      end

      it 'redirects to questions_path' do
        expect(response).to redirect_to questions_path
      end
    end
  end

  describe "DELETE #destroy" do
    context do 'Author'
      before do 
        question
        login(question.user)
      end
      it 'deletes question from DB if ' do
        expect { delete :destroy, id: question, format: :js }.to change(Question, :count).by(-1)
      end

      it 'renders js template destroy' do
        delete :destroy, id: question, format: :js
        expect(response).to render_template :destroy
      end
    end

    context do 'Non-author'
      before do 
        question
        login(user)
      end
      it 'Does not delete question from DB if ' do
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'redirects to index' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end 
    end
  end

end