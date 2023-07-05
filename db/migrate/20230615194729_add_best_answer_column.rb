class AddBestAnswerColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :best, :boolean, null: false, default: false
  end
end
