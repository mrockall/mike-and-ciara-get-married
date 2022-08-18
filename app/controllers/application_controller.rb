class ApplicationController < ActionController::Base
  def index
    @question = Question.order(Arel.sql('RANDOM()')).first
    @photos_for_page = get_page_of_photos
  end

  def details_of_the_day
    @page_title = "Details of the Day"
    @photos_for_page = get_page_of_photos
  end

  def where_to_stay
    @page_title = "Where to Stay"
    @photos_for_page = get_page_of_photos
  end

  def rsvp
    @page_title = "RSVP"
    @photos_for_page = get_page_of_photos
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

  def church_game
    
  end

  private

  def get_page_of_photos
    page_size = 8
    all_photos = Dir[Rails.root.join('app', 'assets', 'images', 'photo_grid', '*')]
    all_photos.shuffle.first(page_size)
  end
end
