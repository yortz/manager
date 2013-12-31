require 'bundler'
require 'pathname'
require 'fileutils'
require 'capybara-jasmine'
require 'capybara/poltergeist'
require 'rake/clean'
require 'sinatra/activerecord/rake'
require 'sprockets'
require 'yui/compressor'
require 'uglifier'
require 'coffee-script'
#require 'active_record'
require 'yaml'
require 'rspec/core'
require 'rspec/core/rake_task'

Bundler.require
include FileUtils

ROOT        = Pathname(File.dirname(__FILE__))
PUBLIC_DIR  = ROOT.join("public")
ASSETS      = %w{ application.js application.css }
PATHS       = %w{ frontend css vendor }

CLEAN.include "spec/*.js"

rule '.js' => '.coffee' do |t|
  puts "Compiling #{t.source} => #{t.name}"
  File.write(t.name, CoffeeScript.compile(File.read(t.source)))
end

FileList['spec/javascripts/**/*.coffee'].ext('js').each do |f|
  task :coffee => f
end

Capybara::Jasmine::TestTask.new "testjs" => "coffee" do |t|
  Capybara.javascript_driver = :poltergeist
  t.lib_files = FileList[
    "spec/javascripts/support/sinon-1.7.3.js",
    "spec/javascripts/support/jasmine-sinon.js",
    "spec/javascripts/fixtures/*.js",
    "spec/javascripts/templates/*.js",
    "spec/javascripts/spec_helper.js",
    "public/application.js",
    "spec/javascripts/support/jasmine-jquery.js"
  ].uniq
  t.spec_files = FileList["spec/javascripts/**/*spec.js"]
end

desc 'Compile assets to build directory'
task :compile => :cleanup do
  time_start = Time.now
  Dir.mkdir PUBLIC_DIR if !File.exists?(PUBLIC_DIR)

  sprockets = Sprockets::Environment.new

  unless ENV['RAKE_ENV'] == "development"
    sprockets.css_compressor = YUI::CssCompressor.new
    sprockets.js_compressor  = Uglifier.new
  end

  PATHS.each do |path|
    sprockets.append_path(ROOT.join("#{path}").to_s)
  end

  ASSETS.each do |asset_name|
    puts "Compiling #{asset_name}"
    asset = sprockets[asset_name]
    prefix, basename = asset.pathname.to_s
    asset.write_to PUBLIC_DIR.join(asset_name)
  end

  time_end = Time.now
  puts "Assets compiled in #{(time_end - time_start).to_i} seconds"
end

desc 'Clean up precompiled js and css'
task :cleanup do
  puts "Cleaning up build directory..."
  ASSETS.each { |asset| FileUtils.rm_r([PUBLIC_DIR, asset].join("/"), force: true) }
end



namespace :db do

  task :environment do
    @config = YAML::load(File.open(File.dirname(__FILE__) + '/db/database.yml'))
    ActiveRecord::Base.establish_connection(@config)
  end

  desc "Create database"
  task :create do
    config = YAML::load(File.open(File.dirname(__FILE__) + '/db/database.yml'))
    begin
      ActiveRecord::Base.establish_connection(database: nil, adapter: 'mysql')
      ActiveRecord::Base.connection.create_database(config['database'])
    rescue Exception => e
      puts e
    end
  end

  desc "Drop database"
  task :drop => :environment do
    begin
      ActiveRecord::Base.connection.drop_database @config['database']
      puts "database successfully deleted"
    rescue Exception => e
      puts e
    end
  end

  desc "Migrate the database"
  task :migrate => :environment do
    begin
      ActiveRecord::Migrator.migrate('db/migrate')
    rescue Exception => e
      puts e
    end
  end

  desc 'Load the seed data from db/seeds.rb'
  task :seed => :environment do
    seed_file = File.join('db/seeds.rb')
    load(seed_file) if File.exist?(seed_file)
  end

end

task :default => :spec
desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

task :test => ['coffee', 'compile', 'testjs']
