# Preview all emails at http://localhost:3000/rails/mailers/delivery_mail
class DeliveryMailPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/delivery_mail/send
  def send
    DeliveryMail.send
  end

end
