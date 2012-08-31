class CreatePageParts < ActiveRecord::Migration
  def change
    create_table :mcms_page_parts do |t|
      t.text :body

      t.timestamps
    end
    
  end
end
