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
    user_is_pudo? || user_is_admin?
  end

  def edit?
    update?
  end

  def update?
    user_is_pudo? || user_is_admin?
  end

  def show?
    true
    #record.user == user
  end

  def preview?
    record.owner == user || user_is_admin?
  end

  def decode?
    true
  end

  def become_owner?
    true
  end

  def retrieve_owner?
    true
  end

  private

  def user_is_admin?
    user.admin
  end

  def user_is_pudo?
    user.pudo
  end
end



