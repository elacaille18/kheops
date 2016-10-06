class ParcelPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    true
  end

  def show?
    true
    #record.user == user
  end

  def preview?
    true
  end

  def decode?
    true
  end
end
