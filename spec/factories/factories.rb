FactoryGirl.define do
  factory :group_event do
    name 'test'
    location 'test location'
    user_id 1
    starts_at Date.today
    ends_at  Date.today + 10.days
    original_description 'Test original description'

    factory :group_event_alpha do
      name 'test name alpha'
      location 'test location alpha'
      original_description 'Test original description alpha'
    end

    factory :group_event_omega do
      name 'test name omega'
      location 'test location omega'
      original_description 'Test original description omega'
    end
  
  end
end
