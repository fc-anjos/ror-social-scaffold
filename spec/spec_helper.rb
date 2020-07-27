require 'simplecov'
SimpleCov.start do
  add_filter 'config/'
  add_filter 'spec/'
  add_filter 'app/helpers/application_helper.rb/'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Views', 'app/views'
  add_group 'Helpers', 'app/helpers'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
