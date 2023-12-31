FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    bio { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
    
    after(:build) do |user|
      user.profile_image.attach(io: File.open('spec/images/choco.jpeg'), filename: 'profile_image.jpeg', content_type: 'application/xlsx')
    end
  end
end