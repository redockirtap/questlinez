# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all
  end

  def show
    answer.links.build
  end

  def new
    question.links.build # create association with link model
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Your question is created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if question.update(question_params) && current_user.author?(question)
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = 'Your question is updated.' }
      end
    else
      render :edit, status: :unprocessable_entity, formats: :html
    end
  end

  def destroy
    return unless current_user.author?(question)

    question.destroy
    redirect_to questions_path, notice: 'Question is deleted.'
  end

  private

  helper_method :questions, :question, :answer

  def questions
    @questions = Question.all
  end

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  def answer
    @answer ||= question.answers.new
  end

  def question_params
    params.require(:question).permit(:title, :body,
                                     files: [], links_attributes: [:name, :url, :_destroy])
  end
end
