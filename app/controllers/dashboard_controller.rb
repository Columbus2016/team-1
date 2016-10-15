class DashboardController < ApplicationController
  ## MEGA ULTRA HACK
  def index
    users = User.visible.by_filter(params, current_user)
    @dashboard = DashboardQuery.new(users)
    respond_to do |format|
      format.html
      format.json { render json: @dashboard.to_h }
    end
  end
end
