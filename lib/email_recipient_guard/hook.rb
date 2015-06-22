module EmailRecipientGuard
  class Hook
    def self.delivering_email(message)
      return unless Rails.application.config.email_recipient

      message.to = create_recipient(message[:to])
      message.cc = message[:cc] ? create_recipient(message[:cc]) : nil
      message.bcc = message[:bcc] ? create_recipient(message[:bcc]) : nil
    end

    def self.create_recipient(email)
      %Q/"#{email.to_s.gsub('"', '')}" <#{Rails.application.config.email_recipient}>/
    end
  end
end
