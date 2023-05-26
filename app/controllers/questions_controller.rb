class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question is created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path
  end

  private

  helper_method :questions, :question, :answer

  def questions
    @questions = Question.all
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  def answer
    question.answers.new
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
