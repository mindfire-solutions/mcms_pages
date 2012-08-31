=begin

  @File Name                 : routes.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             :
  @Last Modification Details :
  @Purpose                   : To redirect the pages throughout the application.

=end

Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  #resources :pages

  # defining root path for the application
  #root :to => "pages#home"

  # post to page preview action
  post 'pages/preview'     => 'pages#preview', :as => :preview_pages

  match 'pages/blog/preview' => redirect("/blog/posts") if Gem.available?("mcms_blog")

  # match pages/**/preview to action preview of pages controller
  match 'pages/*path/preview' => 'pages#preview', :as => :preview_page,  :via => [:get, :put]

  # define route for namespace admin for different resources to have
  # path prefixed with "mcms"
  namespace :admin, :path => "mcms" do

    # matching pages/page_title OR id/find_child will be redirected to
    # find_child action for pages controller within namespace admin
    match 'pages/*path/find_child', :to => 'pages#find_child'

    # get edit path for parent and child(url prepended with parent) page both
    # and redirect to edit action
    get 'pages/*path/edit', :to => 'pages#edit'

    resources :layouts do

      collection do

        get 'find_and_use_layout'

      end

    end

    resources :pages do

      collection do

        get 'add_page_part'

      end

    end

  end # end namespace

  match '/:path' => "pages#show"

  match '*path', :to=> 'pages#show', :as => :show_page unless Gem.available?("mcms")

end

