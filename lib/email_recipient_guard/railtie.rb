module EmailRecipientGuard
  class Railtie < Rails::Railtie
    config.email_recipient = nil

    ActiveSupport.on_load(:action_mailer) do
      ActionMailer::Base.register_interceptor(EmailRecipientGuard::Hook)
    end
  end
end
