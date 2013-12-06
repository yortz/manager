ENV["RACK_ENV"] = "test"

require 'bundler'
Bundler.require :default, :test

require 'factory_girl'
require 'rack/test'
require 'rspec'
require 'database_cleaner'
require_relative '../app'

FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions

ActiveRecord::Base.logger.level = 1

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  App
end


# Request helpers

def get_json(path)
  get path
  json_parse(last_response.body)
end

def post_json(url, data)
  post(url, json(data), { "CONTENT_TYPE" => "application/json" })
  json_parse(last_response.body)
end

# JSON helpers

def json_parse(body)
  MultiJson.load(body, symbolize_keys: true)
end

def json(hash)
  MultiJson.dump(hash, pretty: true)
end

def create_companies(options)
  options.each do |c|
    FactoryGirl.create(:company, address: c[:address], country: c[:country], city: c[:city])
  end
end
