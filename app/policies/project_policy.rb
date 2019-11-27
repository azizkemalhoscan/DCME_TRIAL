class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def index?
    true
  end

  def show?
    record.user == user
  end

  def new?
    true
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def create?
    record.user = user
  end

  def destroy?
    record.user == user
  end
end
