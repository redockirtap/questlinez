# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :body, presence: true

  scope :best_answer, -> { where(best: true) }
  scope :order_best, -> { order(best: :desc) }
  scope :order_desc, -> { order(id: :desc) }

  def set_best
    transaction do
      question.answers.best_answer&.update(best: false)
      update(best: true)
    end
  end
end
