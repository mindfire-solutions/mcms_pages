=begin

  @File Name                 : lib/asset_manager.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-09
  @Date Modified             :
  @Last Modification Details :
  @Purpose                   : To include controller action specific JS and CSS.

=end

class Asset

  # @param = mixed
  # @return = none
  # To include individual CSS file
  def self.include_css file

    # if param is of type Array
    if file.class == Array

      # loop through the param and include all files one by one
      file.each do |f|

        #calling include_css_file_individual to include css file
        include_css_file_individual f

      end # end each loop

    else

      #calling include_css_file_individual to include css file
      include_css_file_individual file

    end # end if

  end # end class method include_css

  # @param = mixed
  # @return = none
  # TO include all JS file
  def self.include_local_library library

    #calling include_js_library to include specific JS files
    include_js_library library, :local

  end # end class method include_local_library

  # @params = mixed(JS files) and type of library
  # @return = none
  # To include JS files
  def self.include_js_library library, type = :local

    #if param is of type array
    if library.class == Array

      # loop through the param and include all JS files one by one
      library.each do |l|

        #calling include_js_library_individual to include js file
        include_js_library_individual l, type

      end # end each loop

    else

       #calling include_js_library_individual to include js file
      include_js_library_individual library, type

    end # end if

  end # end class method include_js_library


  # @param = none
  # @return = Array
  def self.get_libraries

    # return class array
    return @@js_includes

  end # end class method get_libraries

  # @param = none
  # @return = Array
  def self.get_css

    # return class array
    return @@css_includes

  end # end class method get_css


  # declaring private section to be visible within the class only
  private

  # declaring class variable of type array
  @@js_includes = []
  @@css_includes = []


  def self.include_js_library_individual library, type

    # declare a local variable of type string with empty value
    file = ""

    # checking the type of param name type
    case type

      when :local # when it is local

        # check if the class of param library is symbol
        if library.class == Symbol

           # convert symbols into string and assign it to variable file
          file = library.to_s + ".js"

        else

          #assign the name in file variable
          file = library

        end

#      when :contrib
#
#        file = "contrib/" + @@libraries[library]

    end # end case statement

    # include the file into the array
    @@js_includes << file unless file.blank? or @@js_includes.include? file

  end # end private class method include_js_library_individual


  # @param = string or symbol
  # @return = class variable of type array
  def self.include_css_file_individual file

    # if params belongs to symbol class
    if file.class == Symbol

      # convert symbols into string
      file = file.to_s + '.css'

    end # end if

    # include the file into the array
    @@css_includes << file  unless file.blank? or @@css_includes.include? file

  end # end private class method include_css_file_individual

  # declaring class variable of type hash
  @@libraries = {
    # declare the library file here in hash format
    :core_ui            => "ui.core.js",
    :jquery_tab         => "ui.tabs.js"
  }

end # end AssetManager Class

