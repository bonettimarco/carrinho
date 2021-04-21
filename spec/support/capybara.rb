# frozen_string_literal: true

require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/apparition'

# Para visualizar o chrome  headless: false
options = { js_errors: false,
            headless: true,
            timeout: 10,
            skip_image_loading: true,
            browser_options: { 'whitelisted-ips' => '',
                               'no-sandbox' =>  '',
                               'disable-extensions' => '' } }

Capybara.server = :puma, { Silent: true } # To clean up your test output

Capybara.register_driver :apparition_acessibilidade do |app|
  driver_class = Capybara::Accessible::Extensions::Driver.wrap(Capybara::Apparition::Driver)
  driver = driver_class.new(app, options)
  driver.accessible = Capybara::Accessible::Adapters::Apparition.new
  driver
end

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new(app, options)
end

if ENV['ACESSIBILIDADE'] == 'ON'
  Capybara.default_driver = :apparition_acessibilidade
  Capybara.javascript_driver = :apparition_acessibilidade
else
  Capybara.javascript_driver = :apparition
end