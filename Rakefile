require 'sinatra/activerecord/rake'
#require 'active_record'
require 'yaml'
#require_relative 'app'
require 'rspec/core'
require 'rspec/core/rake_task'

task :default => :spec
desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)


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
