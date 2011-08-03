require 'bundler/setup'
require 'coffee-script'
require 'haml/html'
require 'jasmine'

module Compile
  def self.coffee(*files)
    files = Dir['lib/coffee/*.coffee'] if files.empty?
    
    files.each do |file_name|
      js_name = file_name.match(/(.*)\/(.*)\.coffee$/)[2]      
      javascript = CoffeeScript.compile File.read(file_name)
      File.open("public/scripts/#{js_name}.js", 'w'){|f| f.write javascript}
    end
  end
  
  def self.haml(*files)
    files = Dir['lib/haml/*.haml'] if files.empty?
    layout = File.read('lib/haml/layout.haml')
    haml = Haml::Engine.new(layout, {:ugly => true})
    
    files.each do |file_name|
      page_name = file_name.match(/(.*)\/(.*)\.haml$/)[2]
      next if page_name == 'layout'
                
      html = haml.render(scope=Object.new) do |content_type|
        case content_type
          when :title
            scope.instance_variable_get("@haml_buffer").buffer << "XBMC: #{page_name}\n"
          when :partial
            partial = File.read(file_name)
            partial_haml = Haml::Engine.new(partial)
            partial_html = partial_haml.render
            scope.instance_variable_get("@haml_buffer").buffer << partial_html
        end
      end

      File.open("public/#{page_name}.html", 'w') {|f| f.write(html) }
    end
  end
end

load 'jasmine/tasks/jasmine.rake'

desc "compile haml & coffeescript"  
task :compile do
  Compile.haml
  Compile.coffee
end

namespace :compile do
  desc "compile all haml to html"
  task :haml do
    Compile.haml
  end

  desc "compile all coffeescript to javascript"
  task :coffee do
    Compile.coffee
  end  
end
