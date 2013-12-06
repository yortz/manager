require 'spec_helper'

describe "Api::v1::Company" do
  describe "GET /companies" do

    COMPANIES = [ {address: "via le dita dal naso 6", country: "Italy", city: "Milan"},
                  {address: "Broad Street 87", country: "Usa", city: "Richmond"},
                  {address: "M Street 15", country: "Usa", city: "Washington D.C." } ]

    before do
      get "/api/v1/companies"
      create_companies(COMPANIES)
    end

    let(:companies) do
      companies = Company.all
      companies.map { |company| json[:company] }
    end
    let(:json)  { json_parse(last_response.body) }

    it "responds successfully" do
      last_response.status.should be 200
      json[:status].should == "success"
    end

    it "returns 3 companies" do
      companies.size.should equal 3
    end
  end

  describe "POST /companies" do
    before do
      post_json( "/api/v1/companies", {
        company: {
          name: "New Company",
          address: "Broad Street 56 NW",
          city: "Washington DC",
          country: "USA",
          email: "address@domain.com",
          phone: 1234567 }
      })
    end

    let(:resp) { json_parse(last_response.body) }
    it { resp[:status].should == "success" }
    it { resp[:company][:name].should == "New Company" }
    it { resp[:company][:address].should == "Broad Street 56 NW" }
    it { resp[:company][:city].should == "Washington DC" }
    it { resp[:company][:country].should == "USA" }
    it { resp[:company][:phone].should == 1234567 }

    it "creaates a new company" do
     Company.count.should == 1
     Company.first.name.should == "New Company"
     Company.first.address.should == "Broad Street 56 NW"
     Company.first.city.should == "Washington DC"
     Company.first.country.should == "USA"
     Company.first.phone.should == 1234567
    end


  end

  #describe "GET /companies/:id" do
  #end

  #describe "PUT /companies/:id" do
  #end

end
