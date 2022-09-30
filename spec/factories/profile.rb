FactoryBot.define do
    factory :profile do
      first_name                    { FFaker::Artist.name }
      last_name                     { FFaker::DcComics.hero }
    end
end
