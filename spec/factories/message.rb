FactoryBot.define do
  factory :message do
    text { "Hi, how are you?" }
    from { :bot }
  end
end
