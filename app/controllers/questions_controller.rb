class QuestionsController < ApplicationController

<<<<<<< HEAD
	before_action :load_question, only: [:show, :edit, :update, :destroy]

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
		@question = Question.new(question_params)
	 if 
	 	@question.save 
	 	redirect_to @question
	 else 
		render :new
	 end
	end

	def update
	 if @question.update(question_params) 
		redirect_to question
	 else
	 	render :edit
	 end
	end

	def destroy
		@question.destroy
		redirect_to questions_path
	end

		private

		def load_question
			@question = Question.find(params[:id])
		end

		def question_params
			params.require(:question).permit(:title, :body)
		end
=======
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: [:show]
  after_action  :publish_question, only: [:create]

  authorize_resource

  def index
   respond_with(@questions = Question.all)
  end
  
  def show
  end

  def new
   respond_with(@question = Question.new)
  end


  def edit  
  end


  def create
    respond_with(@question = current_user.questions.create(question_params))
  end


  def update
     @question.update(question_params)
  end


  def destroy
    respond_with(@question.destroy)
  end


  private

  def load_question
    @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
  end


  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_delete])
  end

<<<<<<< HEAD
  def author
    redirect_to root_url, notice: "You are not an author" unless @question.user_id == current_user.id
  end
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd

=======
  
>>>>>>> lesson-13
  def publish_question
    PrivatePub.publish_to('/questions', question: @question.to_json) if @question.valid?
  end

end
