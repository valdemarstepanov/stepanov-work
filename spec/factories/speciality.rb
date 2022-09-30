FactoryBot.define do
  factory :speciality do
    name                    { FFaker::Alphanumeric.alphanumeric(number: 2, min_alpha: 1, min_numeric: 1) }
    level                   { FFaker::Job.seniority }
  end
end
