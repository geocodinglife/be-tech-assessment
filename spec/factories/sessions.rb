FactoryBot.define do
  factory :session do
    coach_hash_id { '3B6V97csyi1x' }
    client_hash_id { '3B6V97csyi1x' }
    start { DateTime.now }
    duration { 60 }
  end
end
