=begin

  @File Name                 : pages_helper.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-06
  @Date Modified             : 2012-06-15
  @Last Modification Details : default_page_parts method changed
  @Purpose                   : To have view related logic for pages view mainly.

=end

module PagesHelper

  # @Parameters  : integer(column count of a layout)
  # @Return      : Array
  # @purpose     : To give layout a name on the basis of parameter
  def layout_name count

    # using case statement to decide layout name
    case count

      when 2

        return "two-column"

      when 3

        return "three-column"

      when 1

        return "one-column"

      else

        return "default"

    end # end case statement

  end #end method

  # @params    : none
  # @return    : boolean
  # @purpose   : To find
  def deleteable?(page)

    return page.deletable?

  end

  # @param    : Integer
  # @return   : Array
  # @purpose  : To find page parts according to param
  def get_fragments title

     if title != "main body"

       # get page body fragment with title
       part = PagePart.find_page_parts_with_title(title)

     end

  end # end method

  # @param    : Integer(part_index of page part)
  # @return   : Object
  # @purpose  : To build a form object for dynamic creating the page part
  def build_page_part index

    # create a PagePart object and assign it to a variable
    page = PagePart.new

    #make the page part form
    builder = ActionView::Helpers::FormBuilder.new( "page[page_parts_attributes][#{index}]", page, self, {}, proc {})

    #return form object
    return builder

  end # end method

  # @param    : Integer(part_index of page part)
  # @return   : Object
  # @purpose  : To build a form object for dynamic creating the page part
  def build_page_part_page index

    # create a PagePart object and assign it to a variable
    page = PagePartsPage.new

    #make the page part pages form
    builder = ActionView::Helpers::FormBuilder.new( "page[page_parts_pages_attributes][#{index}]", page, self, {}, proc {})

    #return form object
    return builder

  end # end method

  # @param    : Array(page array to be arranged)
  # @return   : Hash
  # @purpose  : To arrange the result and store it in a hash to display the value properly
  def arrange_page_part page

    # find the length of page_parts of current page
    part_length = page.page_parts.length

    # create an empty hash
    part_pages = Hash.new

    #loop through the length of page_part
    for i in 0..part_length-1

      #find each page_part array and assign it in a variable
      part = page.page_parts[i]

      #assign page_part array to hash
      part_pages[part.title] = part

    end # end loop

    # return hash
    part_pages

  end # end method

  # @param    : None
  # @return   : Hash
  # @purpose  : To return hash of all possible layout parts
  def layout_parts

    layout_parts = ["header","footer","left","right","main"]

    layout_parts

  end # end method

end # end module

