class ContactMailer < ApplicationMailer
  default to: "shiboshreeroy169@gmail.com" # change to your admin email

  def notify_admin
    @contact_message = params[:contact_message]
    mail(
      from: @contact_message.email,
      subject: "New Contact Message: #{@contact_message.subject}"
    )
  end
end
