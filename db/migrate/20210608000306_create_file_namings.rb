class CreateFileNamings < ActiveRecord::Migration
  def change
    create_table :file_namings do |t|
      t.string :filename_1
      t.string :filename_2
      t.string :filename_3
      t.string :filename_4
      t.string :filename_format_1
      t.string :filename_format_2
      t.string :filename_format_3
      t.string :filename_format_4
      t.string :filename_sample_1
      t.string :filename_sample_2
      t.string :filename_sample_3
      t.string :filename_sample_4
      t.string :filename_sample_5
      t.string :filename_sample_6
      t.timestamps
    end
  end
end
