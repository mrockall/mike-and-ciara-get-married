class ApplicationController < ActionController::Base
  def index
    @question = Question.order(Arel.sql('RANDOM()')).first
  end

  def answer
    @answer = Answer.find(params[:answer_id])
    redirect_to '/'
  end
end
