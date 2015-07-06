module EmailRecipientGuard
  class Hook
    def self.delivering_email(message)
      return unless recipients = Rails.application.config.email_recipient
      recipients = { to: recipients } unless recipients.is_a? Hash
      raise ArgumentError, "recipient 'to' is not set" unless recipients[:to]

      message.to = create_recipient(message[:to], recipients[:to])
      message.cc = message[:cc] ? create_recipient(message[:cc], recipients[:cc]) : nil
      message.bcc = message[:bcc] ? create_recipient(message[:bcc], recipients[:bcc]) : nil
    end

    def self.create_recipient(name, email)
      return unless email
      %Q/"#{name.to_s.gsub('"', '')}" <#{email}>/
    end
  end
end
