class AddConfigToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :config, :text
  end
end
