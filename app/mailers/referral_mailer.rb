class ReferralMailer < ApplicationMailer
    def invite_email
        @referral = params[:referral]
        @referrer = @referral.referrer
        @link = "#{root_url}users/sign_up?ref=#{@referral.token}"
        mail(to: @referral.invite_email, subject: "#{@referrer.email} invited you to join")
    end
end