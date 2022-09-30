FactoryBot.define do
    factory :grade do
      name                    { FFaker::Job.position }
    end
end
