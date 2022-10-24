FactoryBot.define do
    factory :pool do
      type                    { 'Manager' }
      profile_id              { 1 }
      parent_id               { nil }
    end
end
