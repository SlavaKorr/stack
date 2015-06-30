class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :load_question, only: [:create, :update, :best]

  def create
      @answer = @question.answers.build(answer_params)
      @answer.user_id = current_user.id
      @answer.save
  end

  def update
      @answer = Answer.find(params[:id])
      @question = @answer.question
      @answer.update(answer_params) if @answer.user_id == current_user.id 
  end


  def destroy
      @answer = Answer.find(params[:id])
      @answer.destroy if @answer.user_id == current_user.id
  end

  def best
      @answer = Answer.find(params[:id])
      @question = @answer.question
      @answer.best if current_user.id == @answer.question.user_id
  end


  private

  def load_question
    @question = Question.find_by(id: params[:question_id])
  end


  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end


end
