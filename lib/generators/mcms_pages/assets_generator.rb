=begin

  @File Name                            : assets_generator.rb
	@Company Name                         : Mindfire Solutions Pvt. Ltd.
	@Creator Name                         : Vikram Kumar Mishra
	@Date Created                         : 2012-07-09
  @Date Modified                        :
  @Last Modification Details            :
  @Purpose                              : This file is responsible to install assets and views for mcms_pages module in other application/module

=end

module McmsPages

  module Generators

    # To generate Pages views.
    # copy_views` is the main method and by default copies all views
    module AssetPathTemplates
      extend ActiveSupport::Concern

      included do

        public_task :copy_assets

      end

      # @Params     : None
      # @Returns    : None
      # @Purpose    : To copy stylesheets
      def copy_assets

        asset_directory :mcms_pages

      end # end method

      protected

      # @Params     : None
      # @Returns    : None
      # @Purpose    : To define the source path to copy views
      def asset_directory(name, _target_path = nil)

        directory name.to_s, _target_path || "#{target_path}/#{name}"

      end # end method

      # @Params     : None
      # @Returns    : None
      # @Purpose    : To define the target path to copy views
      def target_path

        @target_path ||= "app/assets/stylesheets"

      end # end method

    end # end module ViewPathTemplates


    class AssetsGenerator < Rails::Generators::Base

      include AssetPathTemplates
      source_root File.expand_path("../../../../app/assets/stylesheets", __FILE__)

      # @Params     : None
      # @Returns    : None
      # @Purpose    : Just to print a line on console
      def install_assets

        say "MCMS PAGES Assets created to your application."

      end # end method

    end # end class

  end # end module Generators

end # end module McmsPages

