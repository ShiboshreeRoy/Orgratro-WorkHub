class UserDashbordController < ApplicationController
  def index
    @links = Link.all
    @total_clicks = current_user.clicks.count
    @total_earned = current_user.total_earned
    @withdrawals = current_user.withdrawals
  end
end
