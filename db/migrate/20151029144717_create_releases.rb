class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.references :user, index: true, foreign_key: true
      t.string :version

      t.timestamps null: false
    end
  end
end
