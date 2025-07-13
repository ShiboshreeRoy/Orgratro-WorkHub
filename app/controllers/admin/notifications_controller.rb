class Admin::NotificationsController < ApplicationController
  #before_action :authenticate_admin! # use Devise or custom logic
  before_action :authenticate_user!

  def new
    @users = User.all
  end

  def create
    selected_ids = params[:user_ids]
    title = params[:notification][:title]
    message = params[:notification][:message]

    if selected_ids.blank? || title.blank? || message.blank?
      redirect_to new_admin_notification_path, alert: "Please fill in all fields and select users."
      return
    end

    selected_ids.each do |user_id|
      Notification.create!(
        user_id: user_id,
        title: title,
        message: message,
        read: false
      )
    end

    redirect_to new_admin_notification_path, notice: "Notification sent successfully!"
  end
end
