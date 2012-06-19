module EmailRecipientGuard
  class Hook
    def self.delivering_email(message)
      return unless Rails.application.config.email_recipient
      message.to = %Q/"#{message['to'].to_s.gsub('"', '')}" <#{Rails.application.config.email_recipient}>/
      message.cc = nil
      message.bcc = nil
    end
  end
end
