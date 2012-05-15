require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    100.times do |n|
      name  = Faker::Company.name
      email = Faker::Internet.email
      phone  = Faker::PhoneNumber.phone_number  
      Supplier.create!(:name => name,
                   :email => email,
                   :phone_number => phone)
    end
  end
end
