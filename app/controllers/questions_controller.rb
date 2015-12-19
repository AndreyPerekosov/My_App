class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :validate_user]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_user, only: [:edit, :destroy, :update]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Your question successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Your question delete!'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def validate_user
    unless current_user.owner_of?(@question)
      redirect_to questions_path, notice: 'You are not author of question!'
    end
  end

end