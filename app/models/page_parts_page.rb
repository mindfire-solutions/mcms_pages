=begin

  @File Name                 : page_parts_page.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-25
  @Date Modified             : 
  @Last Modification Details : 
  @Purpose                   : To deal many to many relationship for page and page_parts
=end

#defining model class to interact with database. It inherits the rails's base class ActiveRecord::Base
class PagePartsPage < ActiveRecord::Base

  #By default it access the table named "pages",
  #so explicitly setting the table name to access required table
  self.table_name = "mcms_page_parts_pages"

  #definig the list of accessible attributes as required by rails
  attr_accessible :page_id, :page_part_id

  # A page_parts_pages will belongs to pages
  belongs_to :page, :foreign_key => :page_id

   # A page_parts_pages will belongs to page_parts
  belongs_to :page_part, :foreign_key => :page_part_id

  # @params  : Array
  # @returns : Array
  # @purpose : To find page_id from page_parts_pages table on the basis of unique page_part_id
  def self.find_unique_page_parts_pages(parts)

    #initialize an empty array
    page_title = Hash.new
    
    # for each parts
    parts.each do |part|

      #find first page id using the page_part part
      page_parts_pages = self.find_by_page_part_id(part.id)

      # insert page title in the array
      page_title[page_parts_pages.page_part.id] = page_parts_pages.page.title if not page_parts_pages.nil?
      
    end # end loop

    # return array of page title
    return page_title

  end # end method
  
end # end class