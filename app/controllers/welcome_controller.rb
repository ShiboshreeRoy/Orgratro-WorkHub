class WelcomeController < ApplicationController
  def index
    @active_user = User.all
     
    @referrals = Referral.includes(:user, :referrer).order(created_at: :desc)
    @recent_referred = Referral.includes(:user, :referrer)
                           .where.not(user_id: nil)
                           .order(created_at: :desc)
                           .limit(10)

 
  end

  def about
  end

  def service
  end

  def contact_us 
  end

  def about_developer
    @dev_name = "Shiboshree Roy"
    @dev_email = "shiboshreeroycse@gmail.com"
    @dev_info = "Full-Stack Developer (Ruby on Rails) | Software Engineer | Tech Enthusiast | OSS Contributor | Content & Script Developer"
    @dev_git ="https://github.com/ShiboshreeRoy"
    @dev_link="https://www.linkedin.com/in/shiboshree-roy"
    @dev_face="https://www.facebook.com/nihalroymatz"
    @dev_cont="+880 1303-8990-27"
  end
end
