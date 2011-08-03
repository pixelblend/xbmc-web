require 'bundler/setup'
require 'fssm'
require 'logger'

require 'coffee-script'
require 'haml/html'
require 'jasmine'


RakeLog = Logger.new(STDOUT)
RakeLog.formatter = proc { |severity, datetime, progname, msg|
  "#{severity} - #{datetime.strftime("%m/%d/%Y %I:%M%p")} - #{msg}\n"
}

module Compile
  CoffeeDir = 'lib/coffee/'
  HamlDir = 'lib/haml/'
  SpecDir = 'spec/lib/'
  
  def self.coffee(*files)
    files = Dir["#{CoffeeDir}*.coffee"] if files.empty?
    
    files.each do |file_name|
      js_name = file_name.match(/(.*)\/(.*)\.coffee$/)[2]      
      RakeLog.info file_name
      
      js_dir = js_name =~ /_spec$/ ? 'spec/javascripts' : 'public/scripts'
      begin
        javascript = CoffeeScript.compile File.read(file_name)
        File.open("#{js_dir}/#{js_name}.js", 'w'){|f| f.write javascript}
      rescue Exception => e
        RakeLog.warn "#{file_name}: #{e}"
      end
    end
  end
  
  def self.haml(*files)
    files = Dir["#{HamlDir}*.haml"] if files.empty?
    
    @layout ||= File.read('lib/haml/layout.haml')
    @haml ||= Haml::Engine.new(@layout, {:ugly => true})
    
    files.each do |file_name|
      page_name = file_name.match(/(.*)\/(.*)\.haml$/)[2]
      if page_name == 'layout' and files != Dir["#{HamlDir}*.haml"]
        #re run all specs
        RakeLog.info "Layout changed; rendering all pages"
        self.haml()
      end
      
      next if page_name == 'layout'
      
      RakeLog.info file_name

      begin
        html = @haml.render(scope=Object.new) do |content_type|
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
      rescue Exception => e
        RakeLog.warn "#{file_name}: #{e}"
      end

      File.open("public/#{page_name}.html", 'w') {|f| f.write(html) }
    end
  end
end

load 'jasmine/tasks/jasmine.rake'

desc "compile haml & coffeescript"  
task :compile do
  Compile.haml 
  Compile.coffee *(Dir[Compile::CoffeeDir+'*.coffee']+Dir[Compile::SpecDir+'*.coffee'])
end

namespace :compile do
  desc "watch and compile haml / coffeescript"
  task :watch => :compile do
    RakeLog.info 'Watching for changes...'
    
    FSSM.monitor do
      path Compile::CoffeeDir do
        glob '*.coffee'

        update {|base, relative| Compile.coffee "#{base}/#{relative}"}
        
        delete do |base, relative| 
          js_file = "public/scripts/#{relative.gsub(/\.coffee$/, '.js')}"
          RakeLog.info "Deleted: #{js_file}"
          File.delete js_file
        end
        
        create {|base, relative| Compile.coffee "#{base}/#{relative}"}
      end

      path Compile::SpecDir do
        glob '*.coffee'

        update {|base, relative| Compile.coffee "#{base}/#{relative}"}
        
        delete do |base, relative| 
          js_file = "spec/javascripts/#{relative.gsub(/\.coffee$/, '.js')}"
          RakeLog.info "Deleted: #{js_file}"
          File.delete js_file
        end
        
        create {|base, relative| Compile.coffee "#{base}/#{relative}"}
      end
      
      path Compile::HamlDir do
        glob '*.haml'
        update {|base, relative| Compile.haml "#{base}/#{relative}"}
        
        delete do |base, relative| 
          html_file = "public/#{relative.gsub(/\.haml$/, '.html')}"
          RakeLog.info "Deleted: #{html_file}"
          File.delete html_file
        end
          
        create {|base, relative| Compile.haml "#{base}/#{relative}"}
      end
    end  
  end
  
  desc "compile all haml to html"
  task :haml do
    Compile.haml
  end

  desc "compile all coffeescript to javascript"
  task :coffee do
    Compile.coffee
  end  
end
