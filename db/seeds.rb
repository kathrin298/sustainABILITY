
Job.destroy_all
Company.destroy_all
Developer.destroy_all
User.destroy_all
# .destroy_all

DEV_EMAILS = ['ivan@email.com', 'brandon@email.com', 'john@email.com', 'kathrin@email.com']
COMPANY_EMAILS = ['jimmy@saveworld.com', 'tommy@renewables.com', 'sven@infotech.com', 'bruce@turbines.com']
INTERESTS = ['Environmentalism', 'Clean Oceans', 'Plastic reduction', 'Climate Change', 'Eco-tourism',
             'Renewable Energy', 'Health Sciences', 'Waste Managment']

puts "seeding developer users..."
DEV_USERS = []
DEV_EMAILS.each do |email|
  user = User.new
  user.email = email
  user.password = 'password'
  user.save
  DEV_USERS << user
end
puts "Seeded dev #{User.all.size} Users"

puts "seeding developers..."
9.times do
  dev = Developer.new
  dev.first_name = Faker::Name.name.split[0]
  dev.last_name = Faker::Name.name.split[1]
  dev.hireable = Developer::HIREABLE_OPTIONS.sample
  dev.user = DEV_USERS.sample
  dev.bio = Faker::Lorem.paragraph(sentence_count: rand(10), supplemental: false, random_sentences_to_add: rand(6))
  dev.location = Faker::Address.city
  dev.interests = INTERESTS.sample
  rand(3).times do
    dev.websites = Faker::Internet.domain_name
  end
  dev.social_links = ['twitter.com', 'facebook.com', 'github.com', 'linkedin.com'].sample(rand(1..4))
  dev.save
end
puts "Seeded #{Developer.all.size} Developers"




puts "seeding company users..."
COMPANY_USERS = []
COMPANY_EMAILS.each do |email|
  user = User.new
  user.email = email
  user.password = 'password'
  user.save
  COMPANY_USERS << user
end
puts "Seeded #{User.all.size} Company Users"

puts "seeding companies..."
3.times do
  company = Company.new
  company.name = Faker::Company.name
  company.user = COMPANY_USERS.sample
  company.bio = Faker::Lorem.paragraph(sentence_count: rand(10), supplemental: false, random_sentences_to_add: rand(6))
  company.location = Faker::Address.city
  company.mission = Faker::Lorem.paragraph(sentence_count: rand(9), supplemental: false, random_sentences_to_add: rand(6))
  company.industry = Company::INDUSTRIES.sample
  company.employees = rand(16)
  company.website = Faker::Internet.domain_name
  company.save

  # Give some jobs to that company
  puts "seeding jobs..."
  rand(0..4).times do
    job = Job.new
    job.job_title = "#{Faker::ProgrammingLanguage.name} developer"
    job.job_description = Faker::Lorem.paragraph(sentence_count: rand(7), supplemental: false, random_sentences_to_add: rand(7))
    job.active = !(rand(1..3) == 1)
    job.company = company
    job.location = Faker::Address.city
    job.remote = (rand(1..3) == 1)
    job.start_date = Job::START_DATES.sample
    job.duration = Job::DURATIONS.sample
    job.save
  end
end
puts "Seeded #{Company.all.size} Companies"





