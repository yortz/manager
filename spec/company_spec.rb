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

  describe "GET /companies/:id" do
    before do
      company = FactoryGirl.create(:company, name: "My Company", phone: 1234567890, address: "Broad Street 56 NW")
      get_json "/api/v1/companies/#{company.id}"
    end

    let(:resp) { json_parse(last_response.body) }
    it { resp[:status].should == "success" }
    it { resp[:company][:name].should == "My Company" }
    it { resp[:company][:address].should == "Broad Street 56 NW" }
    it { resp[:company][:city].should == "Milan" }
    it { resp[:company][:country].should == "Italy" }
    it { resp[:company][:phone].should == 1234567890 }
  end

  describe "PUT /companies/:id" do
    before do
      company = FactoryGirl.create(:company, name: "My Company", phone: 1234567890, address: "Broad Street 56 NW")
      put_json( "/api/v1/companies/#{company.id}", {
        company: {
          name: "New Company",
          address: "Main Street 57",
          city: "Washington DC",
          country: "USA",
          email: "address@domain.com",
          phone: 1234567 }
      })
    end

    let(:resp) { json_parse(last_response.body) }

    it { resp[:status].should == "success" }
    it { resp[:company][:name].should == "New Company" }
    it { resp[:company][:address].should == "Main Street 57" }
    it { resp[:company][:city].should == "Washington DC" }
    it { resp[:company][:country].should == "USA" }
    it { resp[:company][:email].should ==  "address@domain.com"}
    it { resp[:company][:phone].should == 1234567 }
  end

  describe "POST /companies/:id/passports" do
    before do
      company = FactoryGirl.create(:company, name: "My Company", phone: 1234567890, address: "Broad Street 56 NW")
      post_json( "/api/v1/companies/#{company.id}/passports", {
        payload: {
          file_path: "spec/fixtures/lion.pdf",
          original_filename: "lion.pdf",
          kind: "owner" }
      })
    end
    let(:resp) { json_parse(last_response.body) }

    it { resp[:status].should == "success" }
    it { resp[:passport][:kind].should == "owner" }

    it "creates the passport" do
      company = Company.first
      company.passports.size.should == 1
      passport = company.passports.first
      passport.kind.should == "owner"
      passport.file.should_not be nil
    end
  end

end
