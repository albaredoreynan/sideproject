class CreateDocAbbreviations < ActiveRecord::Migration
  def change
    create_table :doc_abbreviations do |t|
      t.string      :document_name
      t.string      :doc_abbreviation
      t.timestamps
    end
  end
end
