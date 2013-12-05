require 'spec_helper'

describe "Api::v1::Company" do
  describe "GET /companies" do
    before          { get "/api/v1/companies" }
    COMPANIES = [ {address: "via le dita dal naso 6", country: "Italy", city: "Milan"},
                  {address: "Broad Street 87", country: "Usa", city: "Richmond"},
                  {address: "M Street 15", country: "Usa", city: "Washington D.C." } ]
    let(:json)      { json_parse(last_response.body) }
    let(:companies) { create_companies(COMPANIES) } #json[:companies] }

    it "responds successfully" do
      last_response.status.should be 200
      json[:status].should == "success"
    end

    it "returns 3 users" do
      companies.size.should equal 3
    end
  end

  #describe "POST /companies" do
  #end

  #describe "GET /companies/:id" do
  #end

  #describe "PUT /companies/:id" do
  #end

end
