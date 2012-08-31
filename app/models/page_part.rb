=begin
  @File Name                 : page_part.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             : 2012-06-08
  @Last Modification Details : Title field validation added
  @Purpose                   : To deal with database table "mcms_page_parts" and all operations related to that table mainly.
                               It may deal with other tables and DB related operations.
=end

#defining model class to interact with database. It inherits the rails's base class ActiveRecord::Base
class PagePart < ActiveRecord::Base

  #By default it access the table named "page_parts",
  #so explicitly setting the table name to access required table
  self.table_name = "mcms_page_parts"

  #defining has_many :through relationship
  has_many :page_parts_pages, :class_name => 'PagePartsPage'

  #defining has_many relation of page_parts to pages through page_part_pages
  has_many :pages, :through => :page_parts_pages

  #defining the list of accessible attributes as required by rails
  attr_accessible :body, :page_id, :title, :page_parts_pages_attributes

  #validating title field to have non-blank value
  validates :title, :presence  => true

  # @param    : string(title of the page part)
  # @return   : array
  # @purpose  : To find all page_parts with given title
  def self.find_page_parts_with_title title

    #find all page parts with title header and assign it to a variable
    part_body = self.find_all_by_title(title)

    # calling method to find unique pages and assigning them to an array
    page_title = PagePartsPage.find_unique_page_parts_pages(part_body)

    # returning the array
    return page_title

  end # end method

  # @param    : none
  # @return   : array
  # @purpose  : It will just return the title of page part
  def self.find_page_parts_with_title_main_body

    return "main body"

  end # end method

  # @param    : Object
  # @return   : none
  # @purpose  : To find all independent page_parts and delete it
  def self.delete_page_parts page

    # loop through page_parts_pages of page and check its page part
    page.page_parts_pages.each do |page_part_page|

      # find page_part by its id and assign it to a variable
      page_part = self.find_by_id(page_part_page.page_part_id)

      # if there is only one page_part for a page then delete it
      if page_part.pages.count == 1 and page_part.pages.first.title == page.title

        # delete page_part
        page_part.destroy

      end # end if

    end # end loop

  end # end method

end  # end class

