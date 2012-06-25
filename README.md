# EmailRecipientGuard

By setting a config option you can configure your outgoing email to always go to the same address (useful for example for development or staging environments).

```ruby
# turn off EmailRecipientGuard (default)
config.email_recipient = nil
# send all emails to test@example.com
config.email_recipient = "test@example.com"
# set the config in another place (for example an initializer)
Rails.application.config.email_recipient = "test@example.com"

## another possible options
## email_recipient needs to be set to make following work!
# send (as CC) to more recipients
config.email_cc_recipient = "test1@example.com"
config.email_cc_recipient = "test1@example.com, test2@example.com"
config.email_cc_recipient = ["test1@example.com", "test2@example.com"]
# prefix subject of outgoing emails
confir.email_subject_prefix = "[test_emails]"
```

EmailRecipientGuard is using an ActionMailer interceptor to change the message before sending. No guarantees that this works for you so please test for yourself!

## License

MIT License. Copyright 2012 autohaus24 GmbH
