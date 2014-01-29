module EmailRecipientGuard
  class Hook
    def self.delivering_email(message)
      return unless Rails.application.config.email_recipient
      email_recipient = Rails.application.config.email_recipient
      email_cc = nil
      if email_recipient.is_a?(Array)
        email_cc = email_recipient[1..-1].join(", ")
        email_recipient = email_recipient.first
      end
      subject_prefix = Rails.application.config.email_subject_prefix
      message.to = %Q/"#{message['to'].to_s.gsub('"', '')}" <#{email_recipient}>/
      message.cc = email_cc
      message.bcc = nil
      message.subject = "#{subject_prefix} #{message.subject}" unless subject_prefix.blank?
    end
  end
end
