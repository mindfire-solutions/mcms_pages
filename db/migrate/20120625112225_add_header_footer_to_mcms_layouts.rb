class AddHeaderFooterToMcmsLayouts < ActiveRecord::Migration
  def change
    add_column :mcms_layouts, :header, :boolean
    add_column :mcms_layouts, :footer, :boolean
  end
end
