class DeliveryMail < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.delivery_mail.send.subject
  #
  def send_mail(delivery)
    @delivery = delivery
    mail from: 'shoes.style69@gmail.com', to: @delivery.email, subject: "Магазин женской обуви Стиль"
  end
end
