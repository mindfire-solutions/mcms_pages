class DropColumnPermalinkFromMcmsPages < ActiveRecord::Migration
  
  def change
    
     remove_column :mcms_pages, :permalink
     remove_index  :mcms_pages, :link_url
     
  end

end
