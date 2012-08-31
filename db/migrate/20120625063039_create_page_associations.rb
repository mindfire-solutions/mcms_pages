class CreatePageAssociations < ActiveRecord::Migration
  def change
    create_table :mcms_page_parts_pages do |t|
      t.references :page
      t.references :page_part

      t.timestamps
    end

    add_foreign_key(:mcms_page_parts_pages, :mcms_pages, :column => 'page_id', :dependent => :delete)
    add_foreign_key(:mcms_page_parts_pages, :mcms_page_parts, :column => 'page_part_id', :dependent => :delete)

  end
end
