=begin

  @File Name                 : admin_controller.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             :
  @Last Modification Details :
  @Purpose                   : To check current user's access, It is yet to implement.

=end

class AdminController < ApplicationController

  #admin part
  # check if mcms core layout exists
  if Gem.available?('mcms')

   #if yes then use core layout
   layout "mcms/main_layout"

  else # if not

    # use page's default layout
    layout "mcms_pages/layouts/mcms_layout"

  end # end if

  # use before filter to authenticate user
  prepend_before_filter :authenticate_user!

  # check authorization for a user
  load_and_authorize_resource

  # rescue from record not found exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404


  # @params   : None
  # @return   : None
  # @purpose  : To render 404.html from public folder
  def render_404

    # render data in different format
    respond_to do |format|

      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }

    end # end respond_to block

  end # end method

end # end class

