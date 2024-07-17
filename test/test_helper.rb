ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
require "factory_bot_rails"
require "rails-controller-testing"
require "database_cleaner/active_record"

reporters = []

if ENV["BT_TEST_FORMAT"]&.downcase == "dots"
  # The classic "dot style" output:
  # ...S..E...F...
  reporters.push Minitest::Reporters::DefaultReporter.new
else
  # "Spec style" output that shows you which tests are executing as they run:
  # UserTest
  #   test_details_provided_should_be_true_when_details_are_provided  PASS (0.18s)
  reporters.push Minitest::Reporters::SpecReporter.new(print_failure_summary: true)
end
Minitest::Reporters.use! reporters

class ActionDispatch::IntegrationTest
  setup do
    # Mock Vite helpers
    ActionView::Base.class_eval do
      def vite_javascript_tag(*args)
        ""
      end

      def vite_client_tag
        ""
      end

      def vite_stylesheet_tag(*args)
        ""
      end

      def vite_asset_path(*args)
        ""
      end
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include FactoryBot::Syntax::Methods

    DatabaseCleaner.strategy = :transaction

    setup do
      DatabaseCleaner.start
    end

    teardown do
      DatabaseCleaner.clean
    end
  end
end

Dir[File.expand_path("support/**/*.rb", __dir__)].each { |rb| require(rb) }
