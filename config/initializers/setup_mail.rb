require 'mail'

if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.mailgun.com',
    port:           '587',
    user_name:      ENV['MAILGUN_USERNAME'],
    password:       ENV['MAILGUN_PASSWORD'],
    openssl_verify_mode: 'none'
  }
end