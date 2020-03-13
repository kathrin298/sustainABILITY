class Skill < ApplicationRecord
  BASIC_SKILLS = ['Ruby', 'HTML', 'CSS', 'JavaScript', 'Python', 'Ruby on Rails',
                  'Django', 'NodeJS', 'Java', 'Scala', '.NET', 'C#', 'Wordpress',
                  'ExpressJS', 'Elixir', 'AngularJS', 'ReactJS']
  has_many :job_skills
  has_many :developer_skills
end
