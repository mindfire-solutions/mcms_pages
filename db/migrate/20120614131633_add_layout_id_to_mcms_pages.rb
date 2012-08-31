class AddLayoutIdToMcmsPages < ActiveRecord::Migration
  def change
    add_column :mcms_pages, :layout_id, :integer
  end
end
