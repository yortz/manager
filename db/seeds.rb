require_relative '../app.rb'

companies = [
  { 
    name: "Company 1",
    address: "M Street 56th NW",
    city: "Washington D.C.",
    country: "USA",
    email: "email@domain.com",
    phone: 123456
  },
  {
    name: "Company 2",
    address: "U Street 34 NW",
    city: "Washington D.C.",
    country: "USA",
    email: "email@mymail.com",
    phone: 12345667
  },
  {
    name: "Company 3",
    address: "M street 45",
    city: "Washington D.C.",
    country: "USA",
    email: "email@domain.com",
    phone: 123456
  }
]

companies.each do |c|
  Company.create!(name: c[:name], address: c[:address], city: c[:city], country: c[:country], email: c[:email], phone: c[:phone])
end