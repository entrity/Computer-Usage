# Rails 4
require 'cgi'
require 'active_support'

# For key, see Rails.application.secrets[:secret_key_base]
# For upgrading to Rails 5:
# encrypted_cookie_cipher = 'aes-256-gcm'
# key_len = ActiveSupport::MessageEncryptor.key_len('aes-256-gcm')
# secret = key_generator.generate_key(salt, key_len)
# serializer = ActiveSupport::MessageEncryptor::NullSerializer
# encryptor = ActiveSupport::MessageEncryptor.new(secret, cipher: encrypted_cookie_cipher, serializer: serializer)
def decrypt_session_cookie_rails_4(rawcookie, key)
  cookie = CGI::unescape(rawcookie)
  digest = Rails.application.config.action_dispatch.cookies_digest || 'SHA1' # See SerializedCookieJars#digest in `action_dispatch/middleware/cookies.rb`
  key_iter_num = 1000 # See Rails.application.key_generator.instance_variable_get(:@key_generator).instance_variable_get(:@iterations)
  key_len = ActiveSupport::MessageEncryptor.key_len
  key_generator = ActiveSupport::KeyGenerator.new(key, iterations: key_iter_num) # compare Rails.application.key_generator
  secret_salt = Rails.application.config.action_dispatch.encrypted_cookie_salt
  sign_secret_salt = Rails.application.config.action_dispatch.encrypted_signed_cookie_salt
  secret = key_generator.generate_key(secret_salt)[0, key_len]
  sign_secret = key_generator.generate_key(sign_secret_salt)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, digest: digest, serializer: ActiveSupport::MessageEncryptor::NullSerializer)
  decrypted = encryptor.decrypt_and_verify(cookie)
  Marshal.load decrypted
end
# Time to test ... (With data from Arbeit327)
cookie = 'WVFQVTFtbmNxWWJPODZNb3NUMVZzZGtDVjZQNXpMYStFMWdiZlJPMkdjRFRBOGZ5T3pOTzBPKzk3NWxvQUJvTlRRU2t4MXZmdG8rT0I0R2M3Ulh0YXpxRVhNMll5UW1xUHhvVXBLbXozZ3ZyNjB4VDU4dWRIUkxBWjBXbDJhci93YkYrZWswUHdFL0hUNDJaUHo2cEpxbXFvdlFZMjJWVU9KTWhHb3NyalFwTkphd0pUQVZSTXRHbkVqRlFnSGpNVTNFQlVxYlRmT3pWbXNjK0JuQ3FydzQvODRhbmtuU29haGNRbXQ4T3o1ZjhqMk53WTRMa0pVd1hPb2NHTVFQY3dvanE2ZElqUk1Mc21HS0k2SHVuZEZ3OWhjdzZPQnRSMEdVVkQwL2IxSVh5QzNSWVlJZms5c1JJV0lzUE1Zb1NHbEtqYm5nTGRKd1ZSdGpOQ1RZZWthR1A2anRFMEluaTcyWTNaNHJBR1N0dklzMkg1RjVmVmY4azEzV3o0N2Z2LS1wQlowRUZ6cjI3SVFQU0F5bGlYSDNnPT0%3D--19650cc5c3e2599fb43b7235ab4de5a1ce8a46ac'
key = 'aeb977de013ade650b97e0aa5246813591104017871a7753fe186e9634c9129b367306606878985c759ca4fddd17d955207011bb855ef01ed414398b4ac8317b'
decrypt_session_cookie_rails_4(cookie, key)

# Rails 4: alternative 2
# The writer says "I mocked Rails behavior from ActionDispatch::Cookies"
# NB: The value for `secret_key_base` in `env` below gets ignored; the libs _always_ end up using `Rails.application.config.secret_key_base`
def decrypt_session_cookie_rails_4_b(rawcookie, key)
  session_key = Rails.application.config.session_options[:key]
  cookie = CGI::unescape(rawcookie)
  cookies = { session_key => cookie }
  env = {
    "action_dispatch.signed_cookie_salt" => Rails.application.config.action_dispatch.signed_cookie_salt,
    "action_dispatch.encrypted_cookie_salt" => Rails.application.config.action_dispatch.encrypted_cookie_salt,
    "action_dispatch.encrypted_signed_cookie_salt" => Rails.application.config.action_dispatch.encrypted_signed_cookie_salt,
    "action_dispatch.secret_key_base" => Rails.application.secrets.secret_key_base,
    "action_dispatch.cookies_serializer" => Rails.application.config.action_dispatch.cookies_serializer,
    "action_dispatch.key_generator" => Rails.application.key_generator
  }
  mock_request = OpenStruct.new
  mock_request.env = env
  mock_request.cookies = cookies # should be a hash
  jar = ActionDispatch::Cookies::CookieJar.build(mock_request)
  jar.encrypted[session_key]
end
# Time to test ... (With data from Arbeit327)
cookie = 'WVFQVTFtbmNxWWJPODZNb3NUMVZzZGtDVjZQNXpMYStFMWdiZlJPMkdjRFRBOGZ5T3pOTzBPKzk3NWxvQUJvTlRRU2t4MXZmdG8rT0I0R2M3Ulh0YXpxRVhNMll5UW1xUHhvVXBLbXozZ3ZyNjB4VDU4dWRIUkxBWjBXbDJhci93YkYrZWswUHdFL0hUNDJaUHo2cEpxbXFvdlFZMjJWVU9KTWhHb3NyalFwTkphd0pUQVZSTXRHbkVqRlFnSGpNVTNFQlVxYlRmT3pWbXNjK0JuQ3FydzQvODRhbmtuU29haGNRbXQ4T3o1ZjhqMk53WTRMa0pVd1hPb2NHTVFQY3dvanE2ZElqUk1Mc21HS0k2SHVuZEZ3OWhjdzZPQnRSMEdVVkQwL2IxSVh5QzNSWVlJZms5c1JJV0lzUE1Zb1NHbEtqYm5nTGRKd1ZSdGpOQ1RZZWthR1A2anRFMEluaTcyWTNaNHJBR1N0dklzMkg1RjVmVmY4azEzV3o0N2Z2LS1wQlowRUZ6cjI3SVFQU0F5bGlYSDNnPT0%3D--19650cc5c3e2599fb43b7235ab4de5a1ce8a46ac'
key = 'aeb977de013ade650b97e0aa5246813591104017871a7753fe186e9634c9129b367306606878985c759ca4fddd17d955207011bb855ef01ed414398b4ac8317b'
decrypt_session_cookie_rails_4_b(cookie, key)
