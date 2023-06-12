# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :body, presence: true

  scope :order_desc, -> { order(id: :desc) }
end
