=begin

  @File Name                 : page.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             : 2012-06-15
  @Last Modification Details : belongs_to layout added
  @Purpose                   : To deal with database table "mcms_pages" and all operations related to that table mainly.
                               It may deal with other tables and DB related operations.
=end

require 'friendly_id'

#defining model class to interact with database. It inherits the rails's base class ActiveRecord::Base
class Page < ActiveRecord::Base

  # extending gem friendly_id
  extend FriendlyId

  # using title for custom url
  friendly_id :title, use: :slugged

  #By default it access the table named "pages",
  #so explicitly setting the table name to access required table
  self.table_name = "mcms_pages"

  #definig the list of accessible attributes as required by rails
  attr_accessible :link_url, :published, :show_in_menu, :title, :page_parts_attributes, :page_parts_pages_attributes,
                  :parent_id, :layout_id, :slug

  #include rails standard validation for title
  validates :title, :presence => true, :uniqueness => true

  # validating link url using rails standard validator with regular expression
  validates_format_of :link_url,
            :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix unless :link_url.length > 0

  # Nested pages, i.e. page underneath another page
  acts_as_nested_set :dependent => :destroy

  #defining has_many :through relationship
  has_many :page_parts_pages, :class_name => 'PagePartsPage'

  #defining has_many relation of page_parts to pages through page_part_pages
  has_many :page_parts, :through => :page_parts_pages

  # Associating table mcms_pages to itself. That is self referential has_many relationship using the key parent id
  # Hence a page can have many pages
  has_many :children,
           :class_name => "Page",
           :foreign_key => :parent_id,
           :dependent => :destroy

  # Hence a page can belongs to another page
  belongs_to :parent, :class_name => "Page"

  # A page will belongs to a layout
  belongs_to :layout, :class_name => "Layout"


  #Save Parent and child form together by using association with dependents destroy
  accepts_nested_attributes_for :page_parts_pages, :allow_destroy => true
  accepts_nested_attributes_for :page_parts, :allow_destroy => true

  # @params  : None
  # @return  : Array
  # @Purpose : To find title and id of all pages
  def self.find_all_pages

    #finding title and id of all pages
    return self.select("id, title")

  end # end method

  # @param = integer
  # @return = Array
  # Helps to resolve the situation where you have a path and an id
  # If page corresponding to path is not found then try finding page
  # by id.
  def self.find_by_slug_or_id(path, id)

    # if path is present
    if path.present?

      # then call find_by_path method to find the page
      find_by_path(path)

    #if path is not present but ID is present,
    elsif id.present?

      # then call rails find method to find page by id
      find_by_path(id)

    end # end outer if

  end # end method

  # @params    : string(path)
  # @return    : Array(page)
  # @purpose   : With slugs scoped to the parent page we need to find a page by its full path.
  #              For example with about/example we would need to find 'about' and then its child
  #              called 'example' otherwise it may clash with another page called /example.
  def self.find_by_path(path)

    # split the path param and assign it to a variable, and reject spliting if it is blank
    split_path = path.to_s.split('/').reject(&:blank?)

    # find page details using find_by_slug method and assign it to a variable
    page = Page.find_by_slug(split_path.shift)

    # find child page and then details of page using find_by_slug method and assign it to a variable
    page = page.children.find_by_slug(split_path.shift) until page.nil? || split_path.empty?

    # return page variable
    page

  end # end method

  # @params    : none
  # @return    : boolean
  # @purpose   : To check whther the page ios deletable or not
  def deletable?

    # if link url is / or /404 then page is not deletable
    if link_url == '/' || link_url == '/404'

      false

    else

      true

    end # end if

  end # end method

  # @param   : none
  # @return   : none
  # @purpose  : make nested url for child pages in the form of parent/child
  def nested_url

    # find the parent of the current page and convert the current page slug to nested url
    [parent, to_param.to_s].compact.flatten

  end # end method

end #end class

