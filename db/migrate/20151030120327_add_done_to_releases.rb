class AddDoneToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :done, :boolean, default: false
  end
end
