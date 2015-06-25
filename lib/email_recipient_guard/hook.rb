module EmailRecipientGuard
  class Hook
    def self.delivering_email(message)
      return unless Rails.application.config.email_recipient

      if Rails.application.config.email_recipient.is_a? Hash
        email_recipients = Rails.application.config.email_recipient

        message.to = create_recipient(message[:to], email_recipients[:to])
        message.cc = message[:cc] ? create_recipient(message[:cc], email_recipients[:cc]) : nil
        message.bcc = message[:bcc] ? create_recipient(message[:bcc], email_recipients[:bcc]) : nil
      else
        message.to = create_recipient(message[:to], Rails.application.config.email_recipient)
        message.cc = nil
        message.bcc = nil
      end
    end

    def self.create_recipient(name, email)
      %Q/"#{name.to_s.gsub('"', '')}" <#{email}>/
    end
  end
end
