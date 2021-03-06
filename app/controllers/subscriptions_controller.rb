class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_question

  respond_to :js

  authorize_resource

  def create 
    @subscription = current_user.subscriptions.create(question: @question)
    respond_with @subscription
  end

  private

  def load_question
    @question = Question.find_by(id: params[:question_id])
  end

end
