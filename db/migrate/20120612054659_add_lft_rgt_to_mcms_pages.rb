class AddLftRgtToMcmsPages < ActiveRecord::Migration
  def change
    add_column :mcms_pages, :lft, :integer
    add_column :mcms_pages, :rgt, :integer
  end
end
