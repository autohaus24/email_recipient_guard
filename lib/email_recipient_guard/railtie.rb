module EmailRecipientGuard
  class Railtie < Rails::Railtie
    config.email_recipient = nil
    config.email_cc_recipient = nil
    config.email_subject_prefix = nil

    ActiveSupport.on_load(:action_mailer) do
      ActionMailer::Base.register_interceptor(EmailRecipientGuard::Hook)
    end
  end
end
