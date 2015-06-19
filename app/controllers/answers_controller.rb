class AnswersController < ApplicationController

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

end
