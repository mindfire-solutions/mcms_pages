=begin

  @File Name                            : mcms_pagesn_generator.rb
	@Company Name                         : Mindfire Solutions Pvt. Ltd.
	@Creator Name                         : Vikram Kumar Mishra
	@Date Created                         : 2012-07-06
  @Date Modified                        :
  @Last Modification Details            :
  @Purpose                              : This file is responsible to install mcms_pages module in other application/module

=end

class McmsPagesGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  # @Params     : None
  # @Returns    : None
  # @Purpose    : Just to print a line on console
  def install_pages

    say "Installing MCMS_PAGES MODULE"

  end # end method

  # @Params     : None
  # @Returns    : None
  # @Purpose    : To Copy asset_manager from engine to app
  def copy_asset_manager

    #copy file lib/asset_manager.rb to app/lib/asset_manager.rb if it doesn't exists
    copy_file "asset.rb", "lib/asset.rb" unless File.exists?(File.join(destination_root, 'lib', 'asset.rb'))


  end # end method

  # @Params     : None
  # @Returns    : None
  # @Purpose    : To Copy ckeditor initializer from engine to app
  def copy_initializer

    #copy file lib/asset_manager.rb to app/lib/asset_manager.rb if it doesn't exists
    copy_file "ckeditor.rb", "config/initializers/ckeditor.rb" unless File.exists?(File.join(destination_root, 'config/initializers', 'ckeditor.rb'))


  end # end method

  # @Params     : None
  # @Returns    : None
  # @Purpose    : To Copy all the migrations from db/migrate of engine to db/migrate of application
  def add_migrations

    say "copying migrations......."

    # running command line command to copy engine's migration file
    rake("mcms_pages_engine:install:migrations")

  end # end method

  # @Params     : None
  # @Returns    : None
  # @Purpose    : To append seeds data from engine to app's seeds.rb
  def append_seed_data

      # create file deb/seeds.rb to parent app if not exists
      create_file "db/seeds.rb" unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))

      # append data to app's seeds.rb
      append_file 'db/seeds.rb', :verbose => true do

        <<-EOH

        McmsPages::Engine.load_seed

        EOH

      end # end block

  end # end method


  # @Params     : None
  # @Returns    : None
  # @Purpose    : To prompt user for some instrctions on console
  def prompt_user

    say "\ndon't forget to run the following \n

          rake db:migrate\n

          rake db:seed\n

          Add the line\n\n\t\t root :to => 'pages#home'\n\n\t in config/routes.rb file \n

          start the rails server and hit the url http://localhost:3000/mcms/pages\n

          Yay!\n\n"

  end# end method

end

