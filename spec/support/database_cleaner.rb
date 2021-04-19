# frozen_string_literal: true

def clean_all_tables
  DatabaseCleaner[:active_record].clean_with(:truncation)
end

RSpec.configure do |config|
  config.before(:suite) do
    FactoryBot.lint strategy: :build, traits: false
    clean_all_tables
  end

  config.around(:each, transactional_fixtures: false) do |ex|
    self.use_transactional_tests = false
    ex.run
    self.use_transactional_tests = true
    clean_all_tables
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
  end
end