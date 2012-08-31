class AddParentIdToPages < ActiveRecord::Migration
  def change
    add_column :mcms_pages, :parent_id, :integer
  end
end
