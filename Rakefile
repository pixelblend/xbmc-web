require 'bundler/setup'
require 'fssm'
require 'logger'

require 'coffee-script'
require 'haml/html'
require 'jasmine'

require 'colorize'

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
      RakeLog.info file_name.colorize( :black ).colorize( :background => :green )
      
      js_dir = js_name =~ /.spec$/ ? 'spec/javascripts' : 'public/scripts'
      begin
        javascript = CoffeeScript.compile File.read(file_name)
        File.open("#{js_dir}/#{js_name}.js", 'w'){|f| f.write javascript}
      rescue Exception => e
        RakeLog.warn "#{file_name}: #{e}".colorize( :black ).colorize( :background => :red )
      end
    end
  end
  
  def self.haml(*files)
    files = Dir["#{HamlDir}*.haml"] if files.empty?
    
    layout = File.read('lib/haml/layout.haml')
    render_attributes = {:escape_attrs => false}
    
    haml   = Haml::Engine.new(layout, render_attributes)
    partial_html = ''
    
    files.each do |file_name|
      page_name = file_name.match(/(.*)\/(.*)\.haml$/)[2]
      if page_name == 'layout' and files != Dir["#{HamlDir}*.haml"]
        #re run all specs
        RakeLog.info "Layout changed; rendering all pages"
        self.haml()
      end
      
      next if page_name == 'layout'
      RakeLog.info file_name.colorize( :black ).colorize( :background => :green )
      
      scope = {:title => page_name}
      begin
        html = haml.render(scope) do |content_type|
          partial = File.read(file_name)
          partial_haml = Haml::Engine.new(partial,render_attributes)
          partial_html = partial_haml.render()
          scope.instance_variable_get("@haml_buffer").buffer << partial_html
        end
        
        File.open("spec/fixtures/#{page_name}.html", 'w') {|f| f.write(partial_html) }
        File.open("public/#{page_name}.html", 'w') {|f| f.write(html) }
      rescue Exception => e
        RakeLog.warn "#{file_name}: #{e}".colorize( :black ).colorize( :background => :red )
      end
    end
  end
end

load 'jasmine/tasks/jasmine.rake'

Rake.application.instance_eval do
  @tasks.delete 'jasmine:ci'
end

namespace :jasmine do
  task :require_phantom_js do
    sh "which phantomjs" do |ok, res|
      fail 'Cannot find phantomjs on $PATH' unless ok
    end
  end

  task :ci => ['jasmine:require', 'jasmine:require_phantom_js'] do
    support_dir = File.expand_path('spec/javascripts/support', File.dirname(__FILE__))
    config_overrides = File.join(support_dir, 'jasmine_config.rb')
    require config_overrides if File.exists?(config_overrides)
    phantom_js_runner = File.join(support_dir, 'phantom-js-runner.js')

    config = Jasmine::Config.new

    # start the Jasmine server and wait up to 10 seconds for it to be running:
    config.start_jasmine_server
    
    jasmine_url = "#{config.jasmine_host}:#{config.jasmine_server_port}"
    
    puts "Running tests against #{jasmine_url}"
    sh "phantomjs #{phantom_js_runner} #{jasmine_url}" do |ok, res|
      fail 'Jasmine specs failed' unless ok
    end
  end
end

desc "compile haml & coffeescript"  
task :compile do
  Compile.haml 
  Compile.coffee *(Dir[Compile::CoffeeDir+'*.coffee']+Dir[Compile::SpecDir+'*.coffee'])
end

namespace :compile do
  desc "watch and compile haml / coffeescript"
  task :watch => ['jasmine:ci', :compile] do
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
