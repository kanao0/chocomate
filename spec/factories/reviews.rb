FactoryBot.define do
  factory :review do
    user
    product
    body { Faker::Lorem.characters(number: 30) }
    rate { rand(1.0..5.0).round(1) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'images', 'choco.jpg'), 'image/jpeg') }

  end
end