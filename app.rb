require 'sinatra'
require 'sinatra/contrib/all'
require 'multi_json'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require "sinatra/activerecord"

set :database, {adapter: "mysql", database: "manager"}

class PassportUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/company/#{model.id}/passport"
  end

  def extensions_white_list
    %w(pdf)
  end
end

class Company < ActiveRecord::Base
  validates_presence_of :name, :address, :city, :country
  has_many :passports
end

class Passport < ActiveRecord::Base
  BENEFICIARIES = ["drector", "owner"].freeze
  mount_uploader :file, PassportUploader
  belongs_to :company
  validates_presence_of :type
end

class App < Sinatra::Base

  configure do
    enable :logging
    enable :raise_errors, :logging
    enable :show_exceptions
    set :static_cache_control, [:private, max_age: 0, must_revalidate: true]

    # Register plugins
    register Sinatra::Namespace

    # Set default content type to json
    before do
      content_type :json
    end
  end

  namespace "/api/v1" do
    get "/companies" do
      companies = Company.all
      json({ status: "success", companies: companies })
    end
  end

end
