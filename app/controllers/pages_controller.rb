=begin

  @File Name                 : pages_controller.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             :
  @Last Modification Details :
  @Purpose                   : To setup the communication between page model and views related to pages for users,
                               It's yet to be implemented.

=end

class PagesController < ApplicationController

  # define layout to be used by controller
  layout "mcms_pages/layouts/mcms_layout"

  #finding page based on url
  before_filter :get_page, :except => [:preview]

  # GET / or GET /home
  # @params  : none
  # return   : none
  # @purpose : To show the home page
  def home

    # send data in different format
    respond_to do |format|

      format.html{ render :template => 'mcms_pages/pages/show'}# home.html.erb
      format.json { render json: @page }

    end # end respond_to block

  end # end action

  # GET /1 or GET /page-title
  # GET /1.json or GET /page-title.json
  # @params  : integer or string through url
  # return   : none
  # @purpose : To show the page with custom url to the user
  def show

    # if page is not publeshed
    if not @page.published?

      # show page 404
      page_404_error

    # if link_url is present for page
    elsif @page.link_url.present? and @page.link_url != '/404'

      # redirect to given link url
      redirect_to @page.link_url

    else

      # send data in different format
      respond_to do |format|

        format.html{ render :template => 'mcms_pages/pages/show'}# show.html.erb
        format.json { render json: @page }

      end # end respond_to block

    end # end if

  end # end action

  # GET /pages/1 or GET /pages/page-title
  # GET /pages/1.json or GET /pages/page-title.json
  # @params  : integer or string through url
  # return   : none
  # @purpose : To show the page preview with custom url to admin
  def preview

    if get_page(page_not_found = false)

      # Preview existing pages
      @page.attributes = params[:page]

    elsif params[:page]

      # Preview a non-persisted page
      @page = Page.new(params[:page])

      # initializing a loop variable
      i = @page.page_parts.length

      # looping through page_parts_pages to retrieve all page_parts
      params[:page]["page_parts_pages_attributes"].each do |k,v|

        # retrieve existing page_parts from DB and assign it to @page array
        @page.page_parts[i] = PagePart.find_by_id(v["page_part_id"]);

        i = i + 1 # incrementing the loop variable

      end # end loop

    end # end if

    # send data in different format
    respond_to do |format|

      format.html{ render :template => 'mcms_pages/pages/show'}
      format.json { render json: @page }

    end # end respond_to block

  end # end method preview

  #defining controller specific method as protected
  protected

  # @param   : boolean(optional)
  # @return  : none
  # @purpose : To find a page if it exists or show the page not found error
  def get_page(page_not_found = true)

    if params[:path] == "mcms" or params[:id] == "mcms"

      redirect_to mcms_users_login_path

    else

      @menu_pages = Page.where("published = ? and show_in_menu = ?", true, true)

      # case statement based on current action and assign the result to instance variable
      case action_name

        # when action is home
        when "home"

          # find page bbased on link url
          @page = Page.where(:link_url => '/').first

        # when action is show or preview
        when "show", "preview"

          # find page using path or id of page
          @page = Page.find_by_slug_or_id(params[:path], params[:id])

      end # end case statement

      # return page or page not found error
      @page || ( page_404_error if page_not_found)

    end

  end # end method

  # @param   : none
  # @return  : none
  # @purpose : To show custom 404 page if page with given ID does not exist
  def page_404_error

    # find page based on link_url and assign it to an instance variable
    @page = Page.where(:link_url => "/404").first

     # send data in different format
     respond_to do |format|

       format.html{ render :template => 'mcms_pages/pages/show'}# show.html.erb
       format.json { render json: @page }

     end # end respond_to block


  end # end method

end #end class

