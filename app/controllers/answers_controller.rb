class AnswersController < ApplicationController
  before_action :set_answer, only: [:destroy, :validate_user, :edit, :update]
  before_action :authenticate_user!
  before_action :validate_user, only: [:destroy, :edit, :update]
  def new
    @answer = Answer.new
  end

  def edit
  end
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    #respond in few different formats
    respond_to do |format|
      if @answer.save
        format.html {redirect_to @question, notice: 'Your answer successfully created'} #respond in html format (for client, that does not support javascript for example)
        format.js #respond in js  
        format.json { render json: @answer } #respond in json format. In this respond we transer @answer for parcing it in js-script(on client side)
      else
        format.html {render 'questions/show'}
        format.js
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity } #transfer errors whith status
      end   
    end
  end

  def update
    @answer.update(answer_params) if @answer.save
  end

  def destroy
    @answer.destroy
  end


  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def validate_user
    unless current_user.owner_of?(@answer)
      redirect_to @answer.question, notice: 'You are not author of answer!'
    end
  end
end