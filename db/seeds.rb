=begin

  @File Name                 : seeds.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Creator Name              : Vikram Kumar Mishra
  @Date Created              : 2012-06-05
  @Date Modified             : 2012-06-19
  @Last Modification Details : modified to create records in DB.
  @Purpose                   : This file should contain all the record creation needed to seed the database with its default values,
                               The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

=end

if Layout.all.empty?

  Layout.create([
                  { :name => "one column", :lft => 0, :rgt => 0, :main => 1, :header => 1, :footer => 1, :column_count => 1 },
                  { :name => "two column with right", :lft => 0, :rgt => 1, :main => 1, :header => 1, :footer => 1, :column_count => 2 },
                  { :name => "two column with left", :lft => 1, :rgt => 0, :main => 1, :header => 1, :footer => 1, :column_count => 2 },
                  { :name => "three column", :lft => 1, :rgt => 1, :main => 1, :header => 1, :footer => 1, :column_count => 3 },
                  { :name => "default", :lft => 0, :rgt => 0, :main => 1, :header => 0, :footer => 0, :column_count => 0 },
                  { :name => "one column without header", :lft => 0, :rgt => 0, :main => 1, :header => 0, :footer => 1, :column_count => 1 },
                  { :name => "two column without header", :lft => 0, :rgt => 1, :main => 1, :header => 0, :footer => 1, :column_count => 2},
                  { :name => "two column with left without header", :lft =>1, :rgt => 0, :main => 1, :header => 0, :footer => 1, :column_count => 2},
                  { :name => "three column without header", :lft => 1, :rgt => 1, :main => 1, :header => 0, :footer => 1, :column_count => 3},
                  { :name => "one column without footer", :lft => 0, :rgt => 0, :main => 1, :header => 1, :footer => 0, :column_count => 1},
                  { :name => "two column without footer", :lft => 0, :rgt => 1, :main => 1, :header => 1, :footer => 0, :column_count => 2},
                  { :name => "two column with left without footer", :lft => 1, :rgt => 0, :main => 1, :header => 1, :footer => 0, :column_count => 2},
                  { :name => "three column without footer", :lft => 1, :rgt => 1, :main => 1, :header => 1, :footer => 0, :column_count => 2},
                  { :name => "two column without left", :lft => 1, :rgt => 0, :main => 1, :header => 0, :footer => 0, :column_count => 2},
                  { :name => "two column without right", :lft => 0, :rgt => 1, :main => 1, :header => 0, :footer => 0, :column_count => 2},
                  { :name => "three column without header footer", :lft => 1, :rgt => 1, :main => 1, :header => 0, :footer => 0, :column_count => 3}
               ])


end

if Page.where(:link_url => "/").empty?

  home_page = Page.create!({

              :title => "Home",
              :link_url => "/",
              :layout_id => "1",
              :show_in_menu => "1",
              :published => "1"

            })

  home_page.page_parts.create({

                :title => "header",
                :body => "<p>Header Part of the page.</p>"

            })

  home_page.page_parts.create({

              :title => "footer",
              :body => "<p>Footer part of the page</p>"

            })

  home_page.page_parts.create({

                :title => "main body",
                :body => "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>"

            })


  page_not_found_page = home_page.children.create({

              :title => "Page not found",
              :link_url => "/404",
              :show_in_menu => false,
              :layout_id => "1",
              :published => true

            })

  page_not_found_page.page_parts.create({

                :title => "header",
                :body => ""

            })

  page_not_found_page.page_parts.create({

                :title => "footer",
                :body => ""

            })

  page_not_found_page.page_parts.create({

                :title => "main body",
                :body => "<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href='/'>Return to the home page</a></p>"

            })
end

if Page.find_by_title("About").nil?

  about_us_page = Page.create({

                 :title => "About",
                 :layout_id => "1",
                 :published => "1",
                 :show_in_menu => "1"

            })

  about_us_page.page_parts.create({

                :title => "header",
                :body => "<p>Header Part of the page About.</p>"
            })

  about_us_page.page_parts.create({

              :title => "footer",
              :body => "<p>Footer part of the page About</p>"

            })

  about_us_page.page_parts.create({

                :title => "main body",
                :body => "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla nisi a elit.
                             Duis ultricies orci ut arcu. Ut ac nibh. Duis blandit rhoncus magna. Pellentesque semper risus ut magna.
                             Etiam pulvinar tellus eget diam. Morbi blandit. Donec pulvinar mauris at ligula. Sed pellentesque, ipsum id
                             congue molestie, lectus risus egestas pede, ac viverra diam lacus ac urna. Aenean elit.</p>"

            })

end

