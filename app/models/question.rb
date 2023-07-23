# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: :all_blank

  has_many_attached :files

  validates :title, :body, presence: true
end
