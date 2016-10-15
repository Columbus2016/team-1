class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    ! @user.nil?
  end

  def update?
    @record.user == @user
  end
end
