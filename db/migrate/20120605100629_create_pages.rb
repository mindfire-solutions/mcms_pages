class CreatePages < ActiveRecord::Migration
  def change
    create_table :mcms_pages do |t|
      t.string :title
      t.string :link_url
      t.string :permalink
      t.boolean :show_in_menu
      t.boolean :published

      t.timestamps
    end
    add_index :mcms_pages, :title,     :unique => true
    add_index :mcms_pages, :link_url,  :unique => true
    add_index :mcms_pages, :permalink, :unique => true

  end
end
