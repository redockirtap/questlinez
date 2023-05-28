# frozen_string_literal: true

class AddUserAssociations < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :user, foreign_key: true
    add_reference :answers, :user, foreign_key: true
  end
end
