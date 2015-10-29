class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name
      t.string :content
      t.references :release, index: true, foreign_key: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
