class Skill < ApplicationRecord
  BASIC_SKILLS = ['Ruby', 'HTML', 'CSS', 'JavaScript', 'Python', 'Ruby on Rails']
  has_many :job_skills
  has_many :developer_skills
end
