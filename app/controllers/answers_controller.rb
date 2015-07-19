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

  def create
      @answer = @question.answers.build(answer_params)
      @answer.user_id = current_user.id

      respond_to do |format|

    if @answer.save
      format.js do 
       # PrivatePub.publish_to "/questions/#{@question.id}/answers", answer: @answer.to_json
       # render nothing: true
        end
      else
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
        format.js
      end
    end
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

>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd

end
