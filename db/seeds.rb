CompanyFavourite.destroy_all
DeveloperFavourite.destroy_all
JobSkill.destroy_all
Message.destroy_all
Review.destroy_all
Application.destroy_all
Answer.destroy_all
Question.destroy_all
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
  dev.website = Faker::Internet.domain_name
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
    stack = Faker::ProgrammingLanguage.name
    job.job_title = "#{stack} developer"
    job.job_description = "#{company.name} is a startup created on the principles of doing some good, encouraging growth, sustainability, and progress in all facets of our business. \nWe are a small startup, and currently need some talent to work on our web presence. Currently our tech stack is focused on #{stack}, but we're open to other technologies."
    job.active = !(rand(1..3) == 1)
    job.company = company
    job.location = Faker::Address.city
    job.remote = (rand(1..3) == 1)
    job.start_date = Job::START_DATES.sample
    job.duration = Job::DURATIONS.sample
    question1 = Question.new(content: "Why do you want to work here?")
    question2 = Question.new(content: "What skills can you bring to this project?")
    question3 = Question.new(content: "Can you tell us something about your core values?")
    question1.job = job
    question2.job = job
    question3.job = job
    question1.save
    question2.save
    question3.save

    job.save
  end
end
puts "Seeded #{Company.all.size} Companies"





