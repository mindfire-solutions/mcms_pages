=begin

  @File Name                 : admin/pages_controller.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             : 2012-06-08
  @Last Modification Details : Page part saved successfully
  @Purpose                   : To setup the communication between page model and views related to pages under namespace admin.

=end

class Admin::PagesController < AdminController

  #includes helper file
  include PagesHelper

  # loading controller specific assets
  before_filter :load_assets
  after_filter :clean_pages, :only => [:update]

  # GET /pages
  # GET /pages.json
  # finds all pages created so far and displays it
  # It may change in future
  def index

    # find all pages
    @pages = Page.all

    # send data in different format
    respond_to do |format|
      format.html{render :template => 'mcms_pages/admin/pages/index'}# index.html.erb
      format.json { render json: @pages }
    end # end respond_to

  end # end action

  # GET /pages/new
  # GET /pages/new.json
  # renders the form for new page and also page part
  # to save page and page part together successfully
  def new

    # check if params[:layout_id] is present
    if not params[:layout_id]

      # if not redirect to layout page
      redirect_to admin_layouts_path(:parent_id => params[:parent_id])

    else # params[:layout_id] is present

      #initializing an empty object
      @page = Page.new

      #retrieve parent_id parameter
      @page.parent_id = params[:parent_id]

      #retrieving layout id from params and assigning to a variable
      @layout = params[:layout_id]

      # calling method to find all pages and page parts
      find_pages_and_parts(@layout)

      #calling method to build page parts
      build_page_parts(@parts)

      #sends data in different formats
      respond_to do |format|

        format.html{render :template => 'mcms_pages/admin/pages/new'}# new.html.erb
        format.json { render json: @page }

      end # end respond_to block

    end # end if

  end # end action

  # GET /pages/1/edit
  # finds the page with given ID and displays the
  # fields with value to edit, i.e. edit form
  def edit

    # find page with given ID
    #@page = Page.find(params[:id])
    @page = Page.find_by_slug_or_id(params[:path], params[:id])

    if @page.nil?

      raise ActiveRecord::RecordNotFound

    else

     #retrieving layout id from params and assigning to a variable
     @layout = @page["layout_id"]

    end # end if

    # calling method to find all pages and page parts
    find_pages_and_parts(@layout)

    #sends data in different formats
    respond_to do |format|

      format.html{render :template => 'mcms_pages/admin/pages/edit'}# edit.html.erb
      format.json { render json: @page }

    end # end respond_to block

  end # end action

  # POST /pages
  # POST /pages.json
  # saves page with page parts and redirects to the
  # current created page
  def create

    # retrieve page part attributes from params and assign it to a variable
    page_parts = params[:page][:page_parts_attributes]

    # sort the page_parts and reassign it to the params
    params[:page][:page_parts_attributes] = Hash[page_parts.sort]

    #creating the page object with its own and child attributes
    @page = Page.new(params[:page])

    #retrieving layout id from params and assigning to a variable
    @layout = params[:page][:layout_id]

    # calling method to find all pages and page parts
    find_pages_and_parts(@layout)

    # sends the data in different formats
    respond_to do |format|

      if @page.save #page saved successfully

        format.html { redirect_to admin_pages_path, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }

      else #page saving failed, re-render the form

        format.html { render action: "new", :template => 'mcms_pages/admin/pages/new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }

      end # end if

    end # end respond_to block

  end # end action

  # PUT /pages/1
  # PUT /pages/1.json
  # Gets the ID via put method and updates the field
  # and redirects to current edited page
  def update

    #find the page with given id
    @page = Page.find(params[:id])

    #use updated_at manually, it will update the page table if user hits update button.
    # This may not be trivial, so it may change.
    @page.updated_at = Time.now

    #retrieving layout id from params and assigning to a variable
    @layout = @page[:layout_id]

    # calling method to find all pages and page parts
    find_pages_and_parts(@layout)

    #sends in data in different format
    respond_to do |format|

      if @page.update_attributes(params[:page]) #page updated successfully

        format.html { redirect_to admin_pages_path, notice: 'Page was successfully updated.' }
        format.json { head :no_content }

      else #page saving failed, re-renders edit template

        format.html { render action: "edit", :template => 'mcms_pages/admin/pages/edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }

      end # end if

    end # end respond_to block

  end # end action

  # DELETE /pages/1
  # DELETE /pages/1.json
  # destroys the page on the basis of ID
  # and redirects to all pages path
  def destroy

    # find the page with with
    @page = Page.find(params[:id])

    # calling class method of PagePart model to delete page parts of a page
    PagePart.delete_page_parts(@page)

    #destroy the page
    @page.destroy

    #sends in data in different format to index action
    respond_to do |format|

      format.html { redirect_to admin_pages_url }
      format.json { head :no_content }

    end # end respond_to block

  end # end action


  # @param   : None
  # @return  : None
  # @purpose : To find a child page
  def find_child

    # find page based on path or slug
    @page = Page.find_by_slug(params[:path])

    #sends in data in different format to index action
    respond_to do |format|

      format.html { render :template => 'mcms_pages/admin/pages/find_child', :layout => false }
      format.json { head :no_content }

    end # end respond_to block

  end

  # @param    : string
  # @return   : None
  # @purpose  : To render a page part pages dynamically
  def add_page_part

    #retrieve parameters and assign these to  instance variables
    @title = params[:title]
    @index = params[:index]
    @part = params[:part]

    # render js.erb
    respond_to do |format|

      format.js{render :template => 'mcms_pages/admin/pages/add_page_part'}

    end # end respond_to

  end # end method


  #defining controller specific method as protected
  protected

  #calling library class AssetManager's methods to include specific js and css files
  def load_assets

    # class method call to include js files
    Asset.include_local_library [:application, :pageFormAdmin, "ckeditor/init"]

    # class method call to include css files
    Asset.include_css ["mcms_pages/pages", "mcms_pages/page_form", "mcms_pages/tabs"]

  end # end method

  # @param    : Array
  # @return   : None
  # @purpose  : To build page parts for a page
  def build_page_parts(parts)

    #renders the form field for each part of layout
    parts.each_with_index do |page_part, index|

      fragment = get_fragments(page_part)

      # check if same type of fragment is already created
      if fragment.nil? or fragment.blank? or fragment.empty?

        # if not then build child pages for all parts of the layout
        @page.page_parts.build(:title => page_part)

      else

        # if yes then build child form for page_part_pages
        @page.page_parts_pages.build

      end # end if

    end # end loop

  end # end method

  def find_pages_and_parts layout

    # storing the array returned by helper method to
    # decide the page parts in a layout
    @parts = Layout.find_page_parts(layout)

  end # end method

  # @param    : None
  # @return   : None
  # @purpose  : To delete orphan record
  def clean_pages

    # find all records in the table mcms_page_parts
    page_parts = PagePart.all

    # loop through all page_parts array
    page_parts.each do |page_part|

      # find page_part_page corresponding to a page_part
      page_part_page = PagePartsPage.where("page_part_id = ?", page_part.id).first

      # check if there is no page_part_page corresponding to a page_part
      if page_part_page.nil? or page_part_page.blank?

        # find page part with relevent id and delete it
        part = PagePart.find(page_part.id)
        part.destroy

      end # end if

    end # end loop

  end # end method

end #end class

