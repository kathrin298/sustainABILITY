DeveloperSkill.destroy_all
Skill.destroy_all
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

$VERBOSE = nil

DEV_BIOS = ["After many years as a successful marketer, I felt I wanted to take a change of direction in my career. I had taken some programming courses before, and really enjoyed it. Then I attended a bootcamp and trained in skills like Ruby on Rails and Javascript. Now, I'm hoping to gain some more experience with an organisation that speaks to my values.",
            "I'm hoping to start on my programming journey with a company that helps the environment and is conscious of sustainability. I started coding about a year ago, and I'm still learning the trade. Working for an organisation that allows me to develop while aligning with my values is really important to me.",
            "Need a developer? I'm offering my services to companies that aim to make a difference in the world. I started programming in Java and C++ about 2 years ago, and have recently undertaken training in web development. I really need to get my experience up, and I'd love to work for a company that has altruistic goals – for that, I'd work for the experience alone.",
            "I undertook a coding bootcamp after a year or so of self-taught programming, and now I feel ready to undertake my first challenges in the real world. I've mostly studied Python and the Django framework, but I'd be willing to learn other stacks to up my experience.",
            "I joined this platform to find the right companies to work for. I've worked with a software company for the past 4 years, but the work never seemed to mean anything to me. I'd love to support a cause worth my time. Perhaps your company is a good fit? For now, money is not the most important thing to me, I'd love to make a difference in the world!"]

COMPANY_BIOS = ["We are a small startup with big goals. Currently our ethos is about stopping destructive production mechanisms, and helping to affect change in the way businesses conduct their affairs. We are seeking an enthousiastic programmer to help us with our web platform. Experience is not as important as a willingness to learn, and a desire to see change in the world. Please apply if you thing you would be a good fit for our growing company.",
                "A growing but humble startup, we want to affect change in the world. We're seeking a programming to help with our ongoing development work, and we're hoping that the experience of working for a company with altruistic goals will appeal to candidate. We can't offer much in the way of renumeration, except that you'll be joining a project that will make a difference, and we hope the experience of working for us will spark your career, wherever you may go afterward.",
                "At our company, we're very into sustainability. Our growing number of clients rely on us each day, and we don't like to disappoint. So far, we've been making do with wordpress websites and basic tech, but our growth is sparking the need to upgrade our online presence. We can offer a little renumeration, but mainly we hope that developer will be interested in us for our altruistic approach to business; that's what our core values are all about."]

COMPANY_MISSONS = ["We seek to change the way people look at the world.",
                   "Recycling, ocean cleaning, and plastic-awareness",
                   "Cleaning the air, cleaning the ocean, and working with locals",
                   "Finding the most sustainable way to live",
                   "Being the change we want to see in the world"]

COMPANY_NAMES = ['EcoTRANS Ltd', 'Ocean CL', 'Peter–Gordon Lawrence', 'Fitzpatrick & Conlon', 'TransGlobal',
                'Chavez & Roberts', 'GloboTech', 'Planjis Ltd', 'RightWAY Inc', 'ReCylc', 'Crane Global', 'SkyBlu']


DEV_NAMES = ['ivan', 'brandon', 'john', 'kathrin', 'james', 'beth', 'amanda', 'jennifer', 'kate', 'alina',
             'frank', 'savid', 'david', 'korina', 'seamus', 'petra', 'nyian', 'peter', 'michelle']
INTERESTS = ['Environmentalism', 'Clean Oceans', 'Plastic reduction', 'Climate Change', 'Eco-tourism',
             'Renewable Energy', 'Health Sciences', 'Waste Managment']

JOB_DESCRIPTIONS = ["We are seeking a developer to help us maintain our very new technology stack. Experience is great, but just as important is a developer's ability to learn and gel well with the team. Please apply and let's start messaging to see if you're a good fit!",
                    "Encouragement and fairness are part of our core values, and as such we are seeking to work with someone who shares these values. We are seeking a developer to become an integral part of the team, and hopefully help us create something great. If you're interested please fill out an application and let's get in touch.",
                    "We are looking for the right candidate to help us implement our new platform. Experience is not essential, we'd rather work with a developer who shares our values and can learn our tech stack quickly. If you think you'd be a good fit, please fill out an application and let's get chatting."]

DEV_SLOGANS = ["Enthousiastic about development and about the environment.",
               "Looking to gain experience with a company that shares my values.",
               "Ready to learn, ready to save the world!",
               "Working toward making the world a better place, while learning to code!",
               "Seeking an opportunity to expand my skills, while working for a great startup.",
               "Bringing coding skills to a deserving startup."]


REVIEW_TITLES = ["Top quality work", "A great developer", "Good developer", "Really nice work", "Great work!",
                 "A pleasure to work with", "Great personality, great developer", "A real gem", "Excellent work",
                 "Very knowledgable", "Cordial, punctual, and knowledgable", "Terrific job", "Perfect!",
                 "Super job, great developer", "Would hire again in a hearbeat"]

puts "seeding company users..."

COMPANY_NAMES.each do |name|
  user = User.new
  user.email = "#{name.split[0].downcase}@email.com"
  user.password = 'password'
  user.save

  company = Company.new
  company.name = name
  company.user = user
  company.bio = COMPANY_BIOS.sample
  company.location = Faker::Address.city
  company.mission = COMPANY_MISSONS.sample
  company.industry = Company::INDUSTRIES.sample
  company.employees = rand(16)
  company.website = "#{name.split[0].downcase}.org"
  company.save

  rand(0..4).times do
    job = Job.new
    stack = Skill::BASIC_SKILLS.sample
    job.job_title = "#{stack.capitalize} developer"
    job.job_description = JOB_DESCRIPTIONS.sample
    job.active = !(rand(1..3) == 1)
    job.company = company
    job.location = Faker::Address.city
    job.remote = (rand(1..3) == 1)
    job.start_date = Job::START_DATES.sample
    job.duration = Job::DURATIONS.sample
    question1 = Question.new(content: "Why do you want to work at #{company.name}?")
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


puts "seeding developer users..."

DEV_NAMES.each do |name|
  user = User.new
  user.email = "#{name}@email.com"
  user.password = 'password'
  user.save

  dev = Developer.new
  dev.first_name = name.capitalize
  dev.last_name = Faker::Name.name.split[1]
  dev.hireable = Developer::HIREABLE_OPTIONS.sample
  dev.bio = DEV_BIOS.sample
  dev.location = Faker::Address.city
  dev.interests = INTERESTS.sample
  dev.user = user
  dev.slogan = DEV_SLOGANS.sample
  dev.website = Faker::Internet.domain_name
  dev.facebook =  'facebook.com'
  dev.twitter = 'twitter.com'
  dev.linkedin = 'linkedin.com'
  dev.github = 'github.com'
  dev.save
  rand(1..6).times do
    skill = Skill.new(name: Skill::BASIC_SKILLS.sample)
    skill.save
    devskill = DeveloperSkill.new
    devskill.skill = skill
    devskill.developer = dev
    devskill.save
  end
  rand(1..5).times do
    appl = Application.new
    appl.developer = dev
    appl.job = Job.all.sample
    appl.status = Application::STATUS.sample

    REVIEW_CONTENT = ["#{dev.first_name} did a wonderful job for us, and seemed very knowledgeable. Keep up the great work!",
                    "We loved working with #{dev.first_name}; quick to learn our tricky stack, and professional at all times.",
                    "#{dev.first_name} worked for us for an extended period, we were only sorry to see the relationship end. Trustworthy and knowledgeable, well done #{dev.first_name}!",
                    "A great developer and a wonderful new friend, #{dev.first_name} came to us to tackle a very difficult project. Would definitely hire again!",
                    "#{dev.first_name} was punctual and hard-working right from day one. It was an absolute pleasure. Keep up the good work #{dev.first_name} :)",
                    "Lovely to meet #{dev.first_name}, and an absolute please to work with. Will definitely hire again, if we can afford it!",
                    "A good dev and very eager to learn.",
                    "A great developer and now a good friend, #{dev.first_name} has moved on to better things now but we are still reaping the benefits of the excellent work that was done."]
    rand(5..10).times do
      review = Review.new(title: REVIEW_TITLES.sample, content: REVIEW_CONTENT.sample, rating: rand(3..5))
      # review.developer = appl
      review.save
      appl.review = review
    end
    appl.save
  end


end
puts "Seeded #{Developer.all.size} Developers"








