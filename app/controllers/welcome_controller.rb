class WelcomeController < ApplicationController
  def index
    @active_user = User.all
  end

  def about
  end

  def service
  end

  def contact_us 
  end
end
