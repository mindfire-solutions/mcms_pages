class AddDepthToPages < ActiveRecord::Migration
  def change
    add_column :mcms_pages, :depth, :integer
  end
end
