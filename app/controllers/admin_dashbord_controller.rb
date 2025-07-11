class AdminDashbordController < ApplicationController
   before_action :authenticate_user!
   #before_action :ensure_admin!

  def index
    @total_user = User.all
    @total_click = Click.all
    @total_link = Link.all
     @recent_users = User.order(created_at: :desc).limit(5)
     # @total_withdrawals = Withdrawal.sum(:amount)
  end
end
