# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def new; end

  def create
    answer.user = current_user

    if answer.update(answer_params)
      redirect_to question_path(answer.question), notice: 'Your answer is created.'
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if answer.update(answer_params)
      respond_to do |format|
        format.html { redirect_to question_path(answer.question) }
        format.turbo_stream { flash.now[:notice] = 'Your answer is updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    answer.destroy

    respond_to do |format|
      format.html { redirect_to question_path(answer.question) }
      format.turbo_stream { flash.now[:notice] = 'Your answer is deleted.' }
    end
  end

  private

  helper_method :answer, :question

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
