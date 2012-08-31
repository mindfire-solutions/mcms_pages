module McmsPages
  class Engine < ::Rails::Engine

    require 'paperclip'
    require 'ckeditor'
    require 'foreigner'
    require 'awesome_nested_set'
    require 'mcms_authentication'

    config.autoload_paths += %W( #{config.root}/lib )
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

  end
end

