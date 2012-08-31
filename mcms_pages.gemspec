$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mcms_pages/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mcms_pages"
  s.version     = "0.0.6"
  s.authors     = ["vikram kumar mishra"]
  s.email       = ["mishra.vikramkumar2@gmail.com"]
  s.homepage    = "https://192.168.10.251/svn/SVNHOME/mcms/trunk/mcms_gems/mcms_pages"
  s.summary     = "Integrates a page module in an application which helps in page creation."
  s.description = "Integrates a page module in an application which helps in page creation."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "ckeditor", "3.7.1"
  s.add_dependency "friendly_id"
  s.add_dependency "foreigner"
  s.add_dependency "awesome_nested_set"
  s.add_dependency "paperclip"
  s.add_dependency "mcms_authentication"

end

