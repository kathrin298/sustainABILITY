class JobPolicy < GeneralPolicy
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
    record.company.user == user
  end

  def update?
    record.company.user == user
  end

  def destroy?
    record.company.user == user
  end
end
