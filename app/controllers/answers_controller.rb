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
    flash.now[:notice] = 'Your answer successfully created'  if @answer.save 
       #redirect_to @question, 
    # else
    #   render :new
    # end
  end

  def update
    @answer.update(answer_params) if @answer.save
      #redirect_to @answer.question, notice: 'Your answer successfully updated'
    # else
    #   render :edit
    # end
  end

  def destroy
    @answer.destroy
    #redirect_to @answer.question, notice: 'Your answer delete!'
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