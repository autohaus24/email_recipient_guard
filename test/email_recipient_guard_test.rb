require 'test_helper'

class EmailRecipientGuardTest < ActiveSupport::TestCase
  context "email recipient" do
    setup do
      @send_emails_to = 'send_emails_to@example.com'
      @recipient = 'recipient@example.com'
      ActionMailer::Base.deliveries.clear
    end

    should "not send to the real recipient when email_recipient is set" do
      EmailRecipientGuard::Railtie.config.email_recipient = @send_emails_to

      Notifications.notification(@recipient).deliver

      assert_equal [ @send_emails_to ], ActionMailer::Base.deliveries[0].to
      assert_equal %Q/"#{@recipient}" <#{@send_emails_to}>/, ActionMailer::Base.deliveries[0].header["to"].to_s
    end

    should "correctly format the header" do
      EmailRecipientGuard::Railtie.config.email_recipient = @send_emails_to

      Notifications.notification('test@example.com').deliver
      Notifications.notification('Test <test@example.com>').deliver
      Notifications.notification('"Test" <test@example.com>').deliver
      Notifications.notification('"Test" <test@example.com').deliver

      assert_equal [ @send_emails_to ], ActionMailer::Base.deliveries[0].to
      assert_equal %Q/"test@example.com" <#{@send_emails_to}>/, ActionMailer::Base.deliveries[0].header["to"].to_s
      assert_equal [ @send_emails_to ], ActionMailer::Base.deliveries[1].to
      assert_equal %Q/"Test <test@example.com>" <#{@send_emails_to}>/, ActionMailer::Base.deliveries[1].header["to"].to_s
      assert_equal [ @send_emails_to ], ActionMailer::Base.deliveries[2].to
      assert_equal %Q/"Test <test@example.com>" <#{@send_emails_to}>/, ActionMailer::Base.deliveries[2].header["to"].to_s
      assert_equal [ @send_emails_to ], ActionMailer::Base.deliveries[3].to 
      assert_equal %Q/"Test <test@example.com" <#{@send_emails_to}>/, ActionMailer::Base.deliveries[3].header["to"].to_s
    end

    should "send to the real recipient when email_recipient is set to nil" do
      EmailRecipientGuard::Railtie.config.email_recipient = nil

      Notifications.notification(@recipient).deliver

      assert_equal [ @recipient ], ActionMailer::Base.deliveries[0].to
      assert_equal @recipient, ActionMailer::Base.deliveries[0].header["to"].to_s
    end
  end
end
