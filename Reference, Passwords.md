# Passwords

## Ruby on Rails

### Authlogic
```ruby
# Encrypt password manually
User.acts_as_authentic_config[:crypto_provider].encrypt 'my_password'
```
