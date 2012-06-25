module EmailRecipientGuard
  class Hook
    def self.delivering_email(message)
      return unless Rails.application.config.email_recipient
      cc = Rails.application.config.email_cc_recipient
      subject_prefix = Rails.application.config.email_subject_prefix
      message.to = %Q/"#{message['to'].to_s.gsub('"', '')}" <#{Rails.application.config.email_recipient}>/
      message.cc = cc.blank? ? nil : cc
      message.bcc = nil
      message.subject = "#{subject_prefix} #{message.subject}" unless subject_prefix.blank?
    end
  end
end
