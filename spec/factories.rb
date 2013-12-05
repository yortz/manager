FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "Company_#{n}" }
    address { "Broad Streeth 98" }
    city { "Milan" }
    country { "Italy" }
    sequence(:email) { |n| "email_address#{n}@domain.com" }
    sequence(:phone) { |n| "123#{n}456#{n}" }
  end
end
