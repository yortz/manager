require 'sinatra'
require 'sinatra/contrib/all'
require 'multi_json'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require "sinatra/activerecord"

config = YAML::load(File.open(File.dirname(__FILE__) + '/db/database.yml'))
set :database, {adapter: config["adapter"], database: config["database"]}

# Helpers
module JsonHelpers
  def json(hash)
    MultiJson.dump(hash, pretty: true)
  end

  def parsed_params
    if request.get? || request.form_data?
      parsed = params
    else
      parsed = MultiJson.load(request.body, symbolize_keys: true)
    end

    parsed = {} unless parsed.is_a?(Hash)

    return parsed
  end
end

class PassportUploader < CarrierWave::Uploader::Base

  def store_dir
    "uploads/company/#{model.id}/passport"
  end

  def extensions_white_list
    %w(pdf)
  end
end

class Company < ActiveRecord::Base
  attr_accessor :id
  validates_presence_of :name, :address, :city, :country
  has_many :passports
end

class Passport < ActiveRecord::Base
  BENEFICIARIES = ["drector", "owner"].freeze
  mount_uploader :file, PassportUploader
  belongs_to :company
  validates_presence_of :kind
end

class FilelessIO < StringIO; attr_accessor :original_filename; end

class App < Sinatra::Base

  configure do
    enable :logging
    enable :raise_errors, :logging
    enable :show_exceptions
    set :static_cache_control, [:private, max_age: 0, must_revalidate: true]
    set :show_exceptions, false if ENV["RACK_ENV"] == "test"

    # Register plugins
    register Sinatra::Namespace

  end


  helpers JsonHelpers

  namespace "/api/v1" do

    # Set default content type to json
    before do
      content_type :json
    end

    get "/companies" do
      companies = Company.all
      json({ status: "success", companies: companies })
    end

    post "/companies" do
      company = parsed_params[:company]
      c = Company.new(company)

      if c.save
        json({ status: "success", company: company })
      else
        halt 500
      end
    end

    get "/companies/:id" do
      company = Company.find(parsed_params[:id])

      if company
        json({ status: "success", company: company })
      else
        halt 500
      end
    end

    put "/companies/:id" do
      company = Company.find(params[:id])

      if company.update_attributes(parsed_params[:company])
        json({ status: "success", company: company })
      else
        halt 500
      end
    end

    post "/companies/:id/passports" do
      payload = parsed_params[:payload]
      pdf = File.open(payload[:file_path]) {|f| f.read }
      encoded_pdf = Base64.encode64 pdf
      io = FilelessIO.new(Base64.decode64(encoded_pdf))
      io.original_filename = payload[:original_filename]
      company = Company.find(params[:id])
      passport = company.passports.build
      passport.kind = payload[:kind]
      passport.file = io

      if passport.save
        json({ status: "success", passport: passport })
      else
        halt 500
      end
    end
  end


end

