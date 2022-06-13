class ApplicationController < ActionController::Base
  def index
    @question = Question.order(Arel.sql('RANDOM()')).first
  end

  def details_of_the_day
    
  end

  def where_to_stay
    
  end

  def rsvp
    
  end

  def answer
    @answer = Answer.find(params[:answer_id])

    Answer.increment_counter(:count_chosen, @answer_id)

    if(@answer.is_correct)
      Question.increment_counter(:count_correct, @answer.question_id)
      Category.increment_counter(:count_correct, @answer.question.category_id)
    else
      Question.increment_counter(:count_incorrect, @answer.question_id)
      Category.increment_counter(:count_incorrect, @answer.question.category_id)
    end

    redirect_to '/'
  end
end
