FactoryGirl.define do
  factory :message do
    body { Faker::Book.title }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpg'))}
    user
    group
  end
end
