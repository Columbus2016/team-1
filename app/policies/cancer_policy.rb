class CancerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
        scope
    end
  end

  # All action requires admin
  ApplicationPolicy::Actions.each do |action|
    self.send(:define_method, action) do
      user_admin?
    end
  end
end
