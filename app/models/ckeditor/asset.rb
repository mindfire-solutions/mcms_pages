class Ckeditor::Asset < ActiveRecord::Base

  #self.table_name = "mcms_assets"
  set_table_name "mcms_assets"

  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip
end

