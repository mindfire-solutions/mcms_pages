=begin

  @File Name                 : layout.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-04
  @Date Modified             : 2012-06-15
  @Last Modification Details :
  @Purpose                   : To deal with database table "mcms_layouts" and all operations related to that table mainly.
                               It may deal with other tables and DB related operations.
=end

#defining model class to interact with database. It inherits the rails's base class ActiveRecord::Base
class Layout < ActiveRecord::Base

  #By default it access the table named "pages",
  #so explicitly setting the table name to access required table
  self.table_name = "mcms_layouts"

  #definig the list of accessible attributes as required by rails
  attr_accessible :column_count, :lft, :main, :name, :rgt, :header, :footer

  #Associating table "mcms_pages" with table "mcms_page_parts" using has_many relation
  has_many :pages,
           :foreign_key => :layout_id,
           :class_name => 'Page',
           :inverse_of => :layout,
           :dependent => :destroy

  # @param   : None
  # @return  : Array
  # @purpose : To find all layouts
  def self.find_all_layouts

    # finding all layouts from the DB and return the array
    return self.select("id, name");

  end # end method

  # @param   : integer(layout_id)
  # @return  : Array
  # @purpose : To find the page parts in given layout
  def self.find_page_parts layout_id

    #initializing an array with some default value
    page_part_array = []

    # finding the layout with given id
    layout = self.find_by_id(layout_id)

    # check and include page part in page part array if page part value is
    # true in DB
    page_part_array << "header" if layout["header"]
    page_part_array << "footer" if layout["footer"]
    page_part_array << "left body" if layout["lft"]
    page_part_array << "right body" if layout["rgt"]
    page_part_array << "main body" if layout["main"]

    # return the array
    return page_part_array

  end # end method

end # end class

