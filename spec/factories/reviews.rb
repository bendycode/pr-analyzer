FactoryBot.define do
  factory :review do
    pull_request
    state { "approved" }
    submitted_at { Time.current }
  end
end
