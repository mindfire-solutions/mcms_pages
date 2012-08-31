class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :mcms_layouts do |t|
      t.string :name
      t.boolean :lft
      t.boolean :rgt
      t.boolean :main
      t.integer :column_count

      t.timestamps
    end

    add_index :mcms_layouts, :name,     :unique => true

  end
end

