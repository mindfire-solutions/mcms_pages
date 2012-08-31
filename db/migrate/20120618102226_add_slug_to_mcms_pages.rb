class AddSlugToMcmsPages < ActiveRecord::Migration
  def change
    add_column :mcms_pages, :slug, :string
    add_index :mcms_pages,  :slug, :unique => true
  end
end
