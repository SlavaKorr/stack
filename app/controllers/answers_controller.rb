class AnswersController < ApplicationController

<<<<<<< HEAD
before_action :load_question_id, only: [:index, :create]

def index
	@answers = @question.answers
end

def new
	@answer = Answer.new
end


def create
	@answer = @question.answers.new(answer_params)
  if @answer.save
	redirect_to @question
  else 
  	render :new
  end
end


def destroy
	@answer = Answer.find(params[:id])
	@answer.destroy
    redirect_to @answer.question
end


		private

		def load_question_id
			@question = Question.find(params[:question_id])
		end


		def answer_params
			params.require(:answer).permit(:body)
		end
=======
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :update, :best]
  before_action :load_answer, only: [:update, :destroy, :best]
  before_action :load_question_answer, only: [:update, :best]

  respond_to :js

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user: current_user)))
  end

  def update
      @answer.update(answer_params) if @answer.user_id == current_user.id 
      respond_with @answer
  end


  def destroy
      respond_with(@answer.destroy) if @answer.user_id == current_user.id
  end

  def best
     respond_with(@answer.best) if current_user.id == @answer.question.user_id
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

>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd

end
