FactoryBot.define do
  factory :speciality do
    name                    { FFaker::Name.unique.name }
  end
end
