# the file in 'config/initialize' will run automaticly when the app starts
# put the code that we want to set config options or app's settings
# use 'SENDGRID_USERNAME' and 'SENDGRID_PASSWORD'(variables) instead of enter the account for security concerns

if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        address: 'smtp.sendgrid.net',
        port: '2525',
        authentication: :plain,
        user_name: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'],
        domian: 'heroku.com',
        enable_starttls_auto: true
    }
end