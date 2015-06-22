class Notifications < ActionMailer::Base
  default :from => "from@example.com"

  def notification(recipients)
    @greeting = "Hi"

    mail recipients
  end
end
