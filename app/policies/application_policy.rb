class ApplicationPolicy
  attr_reader :user, :record

  Actions = %w(index? show? new? create? update? edit? destroy?)

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  protected

  def user_admin?
    @user.try(:authority) == "admin"
  end

  def user_mod?
    @user.try(:authority) == "moderator"
  end

  def user_researcher?
    @user.try(:authority) == "researcher"
  end

  def user_logged_in?
    ! @user.nil?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
