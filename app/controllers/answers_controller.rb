class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :load_question, only: [:create, :update, :best]
  before_action :load_answer, only: [:update, :destroy, :best]
  before_action :load_question_answer, only: [:update, :best]

  respond_to :js

  authorize_resource

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user: current_user)))
  end

  def update
      @answer.update(answer_params) 
      respond_with @answer
  end

  def destroy
      respond_with(@answer.destroy)
  end

  def best
     respond_with(@answer.best)
  end


  private

  def load_question
    @question = Question.find_by(id: params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question_answer
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end


end