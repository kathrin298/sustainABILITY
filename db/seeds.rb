
Job.destroy_all
Company.destroy_all
Developer.destroy_all
User.destroy_all
# .destroy_all

DEV_NAMES = ['ivan', 'brandon', 'john', 'kathrin',]
COMPANY_EMAILS = ['jimmy@saveworld.com', 'tommy@renewables.com', 'sven@infotech.com', 'bruce@turbines.com']
INTERESTS = ['Environmentalism', 'Clean Oceans', 'Plastic reduction', 'Climate Change', 'Eco-tourism',
             'Renewable Energy', 'Health Sciences', 'Waste Managment']

puts "seeding developer users..."

DEV_NAMES.each do |name|
  user = User.new
  user.email = "#{name}@email.com"
  user.password = 'password'
  user.save

  dev = Developer.new
  dev.first_name = name
  dev.last_name = Faker::Name.name.split[1]
  dev.hireable = Developer::HIREABLE_OPTIONS.sample
  dev.bio = Faker::Lorem.paragraph(sentence_count: rand(10), supplemental: false, random_sentences_to_add: rand(6))
  dev.location = Faker::Address.city
  dev.interests = INTERESTS.sample
  dev.user = user
  dev.websites = Faker::Internet.domain_name
  dev.facebook =  'facebook.com/3453464'
  dev.twitter = 'twitter.com/2534643'
  dev.linkedin = 'linkedin.com/users/23443'
  dev.github = 'github.com/45443'
  dev.save
end
puts "Seeded #{Developer.all.size} Developers"




puts "seeding company users..."

COMPANY_EMAILS.each do |email|
  user = User.new
  user.email = email
  user.password = 'password'
  user.save

  company = Company.new
  company.name = Faker::Company.name
  company.user = user
  company.bio = Faker::Lorem.paragraph(sentence_count: rand(10), supplemental: false, random_sentences_to_add: rand(6))
  company.location = Faker::Address.city
  company.mission = Faker::Lorem.paragraph(sentence_count: rand(9), supplemental: false, random_sentences_to_add: rand(6))
  company.industry = Company::INDUSTRIES.sample
  company.employees = rand(16)
  company.website = Faker::Internet.domain_name
  company.save

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





