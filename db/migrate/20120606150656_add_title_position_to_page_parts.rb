class AddTitlePositionToPageParts < ActiveRecord::Migration
  def change
    add_column :mcms_page_parts, :title, :string
  end
end
