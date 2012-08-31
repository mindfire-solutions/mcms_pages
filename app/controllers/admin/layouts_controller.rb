=begin

  @File Name                 : admin/layouts_controller.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-15
  @Date Modified             :
  @Last Modification Details :
  @Purpose                   : To setup the communication between layout model and views related to layouts under namespace admin.

=end

class Admin::LayoutsController < AdminController

  #includes helper file
  include PagesHelper

  before_filter :load_assets

  # GET /layouts
  # GET /layouts.json
  # To find all layouts and display it to the user to choose one
  def index

    # find all layouts
    @layouts = Layout.all

    # find parent_id of page if child page is being created
    # if parent_id is not there i.e. child page is not being created,
    # use parent_id as 0
    @page_parent_id = (params[:parent_id]) ? params[:parent_id] : 0

    # send data in different format
    respond_to do |format|

      format.html{render :template => 'mcms_pages/admin/layouts/index'}# index.html.erb
      format.json { render json: @pages }

    end # end respond_to

  end # end action

  # @params   : Array(via GET)
  # @returns  : None
  # purpose   : To find layout id and redirect to new page path with layout id as param
  def find_and_use_layout

    # declare a local variable with default value
    query_string = "1"

    # initializing a local variable with default value false
    value = false

    # spliting the get params and assigning it to an array
    url_param = params[:layout].split(",")

    # looping through all possible layout parts
    layout_parts.each do |layout|

    

      if url_param.include?(layout)
       
        value = true

      else

        value = false

      end

        # check and change string to match column name
        if layout == "left"

          layout = "lft"

        elsif layout == "right"

          layout = "rgt"

        end # end if

        query_string += " AND `" + layout +"` = " + value.to_s

      #end # end if

    end # end loop
    
    # find layout id from query string
    layout_id = Layout.where(query_string).first.id
    puts "xxxxxxxxxxxxxxxxxxxxx#{layout_id}"
    # redirect to new page path with params layout id
    redirect_to new_admin_page_path(:layout_id => layout_id)

  end # end action

  #defining controller specific method as protected
  protected

  #calling library class AssetManager's methods to include specific js and css files
  def load_assets

    # class method call to include css files
    Asset.include_css ["mcms_pages/layout"]

    # class method call to include js files
    Asset.include_local_library [:application]

  end # end method

end # end class

