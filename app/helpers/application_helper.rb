module ApplicationHelper
    def referral_link_for(referral)
        "#{root_url}users/sign_up?ref=#{referral.token}"
    end
end
