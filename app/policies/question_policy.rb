class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def show?
    return true
  end

  def edit?
    record.job.company.user == user
  end

  def update?
    record.job.company.user == user
  end

  def destroy?
    record.job.company.user == user
  end

end
