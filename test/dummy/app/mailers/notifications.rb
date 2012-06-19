class Notifications < ActionMailer::Base
  default :from => "from@example.com"

  def notification(to)
    @greeting = "Hi"

    mail :to => to
  end
end
