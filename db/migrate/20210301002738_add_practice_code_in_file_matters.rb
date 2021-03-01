class AddPracticeCodeInFileMatters < ActiveRecord::Migration
  def change
  	add_column :file_matters, :practice_code, :string
  end
end
