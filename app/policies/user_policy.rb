class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    @user == @record
  end

  def friend?
    ! @user.nil?
  end
end
