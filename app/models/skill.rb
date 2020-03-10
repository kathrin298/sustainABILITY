class Skill < ApplicationRecord
  has_many :job_skills
  has_many :developer_skills
end
