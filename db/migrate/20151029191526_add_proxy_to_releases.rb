class AddProxyToReleases < ActiveRecord::Migration
  def change
    add_reference :releases, :proxy, index: true, foreign_key: true
  end
end
