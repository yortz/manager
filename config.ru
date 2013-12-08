require 'sprockets'
require File.dirname(__FILE__) + "/app.rb"

use App

project_root = File.expand_path(File.dirname(__FILE__))

assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

map '/assets/images' do
   run Rack::Directory.new('assets/images')
end

map "/assets" do
  run assets
end

map "/" do
  @root = File.expand_path(File.join(File.dirname(__FILE__), "public"))

  run Proc.new { |env|
    # Extract the requested path from the request
    req = Rack::Request.new(env)
    index_file = File.join(@root, req.path_info, "index.html")

    if File.exists?(index_file)
      # Rewrite to index
      req.path_info += "index.html"
    end
    # Pass the request to the directory app
    Rack::Directory.new(@root).call(env)
  }
end
