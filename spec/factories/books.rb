FactoryBot.define do

  factory :book do
    title { Faker::Book.title }
    body { "body" }
  end

end
