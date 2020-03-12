class ApplicationPolicy < GeneralPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    return true
  end

  def show?
    return true
  end

  def update?
    record.job.company.user == user
  end
end
