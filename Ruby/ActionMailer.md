# ActionMailer

## Config
In `config/environments/development.rb`:
```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp
secrets = YAML.load_file(Rails.root.join('config','secrets.yml'))
config.action_mailer.smtp_settings = secrets['action_mailer_smtp'].transform_keys(&:to_sym)
config.action_mailer.default_options = { from: secrets['email_sender'], to: secrets['admin_email'] }
```

## with Gmail
_cf. **SMTP** below_
```yaml
-- NB: transform keys to **symbols**
action_mailer_smtp:
  address: smtp.gmail.com
  port: 587
  user_name: [REDACTED]@gmail.com
  domain: gmail.com
  password: [REDACTED]
  authentication: plain
  enable_starttls_auto: true
```

## SMTP
In `config/environments/development.rb`:
```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = YAML.load_file('file.yml').transorm_keys(&:to_sym)
```

## Sendmail
In `config/environments/development.rb`:
```ruby
config.action_mailer.delivery_method = :sendmail
# Defaults to:/
# config.action_mailer.sendmail_settings = {
#   location: '/usr/sbin/sendmail',
#   arguments: '-i -t'
# }
```

## LetterOpener
LetterOpener is a gem for intercepting and displaying emails in development.
In `config/environments/development.rb`:
```ruby
config.action_mailer.delivery_method = :letter_opener
```

## Test credentials/settings
```ruby
settings = Rails.application.config.action_mailer.smtp_settings
smtp = Net::SMTP.new settings[:address], settings[:port]
smtp.enable_starttls_auto if settings[:enable_starttls_auto]
smtp.start(settings[:domain]) do
  smtp.authenticate settings[:user_name], settings[:password], settings[:authentication]
end
```

## Troubleshoot ActionMailer
```ruby
settings = Rails.application.config.action_mailer.smtp_settings
mail = MyMailer.with(my_locals).my_email
mail.message.delivery_method.send(:build_smtp_session).start(settings[:domain], settings[:user_name], settings[:password], settings[:authentication]) do |smtp|
  $stderr.puts '---------------------------------------------'
  $stderr.puts smtp # Does this have what you expect?
  Mail::SMTPConnection.new(:connection => smtp, :return_response => true).deliver!(mail)
end
```
