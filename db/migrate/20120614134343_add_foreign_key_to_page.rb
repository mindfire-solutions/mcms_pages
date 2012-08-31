class AddForeignKeyToPage < ActiveRecord::Migration
  def change
    add_foreign_key(:mcms_pages, :mcms_pages, :column => 'parent_id', :dependent => :delete)
    add_foreign_key(:mcms_pages, :mcms_layouts, :column => 'layout_id', :dependent => :delete)
  end
end
