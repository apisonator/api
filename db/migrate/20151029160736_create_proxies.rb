class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.references :user, index: true, foreign_key: true
      t.string :subdomain
      t.string :endpoint

      t.timestamps null: false
    end

    add_index :proxies, :subdomain, unique: true
  end
end
