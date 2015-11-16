module Fastlane
  module Actions
    # To share this integration with the other fastlane users:
    # - Fork https://github.com/KrauseFx/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

    class XcodeBotStatusAction < Action
      def self.run(params)
        #XCS_ANALYZER_WARNING_CHANGE=0
        #XCS_ANALYZER_WARNING_COUNT=0
        #XCS_BOT_ID=3212366d3753e1ead6e227f55d04df9d
        #XCS_BOT_NAME=DependencyInjectionFramework
        #XCS_BOT_TINY_ID=37DA619
        #XCS_DERIVED_DATA_DIR=/Library/Developer/XcodeServer/Integrations/Caches/3212366d3753e1ead6e227f55d04df9d/DerivedData
        #XCS_ERROR_CHANGE=0
        #XCS_ERROR_COUNT=0
        #XCS_INTEGRATION_ID=f41508e28d9e42026ed2901a6c0249ae
        #XCS_INTEGRATION_NUMBER=23
        #XCS_INTEGRATION_RESULT=succeeded
        #XCS_INTEGRATION_TINY_ID=C861CE7
        #XCS_TESTS_CHANGE=0
        #XCS_TESTS_COUNT=0
        #XCS_TEST_FAILURE_CHANGE=0
        #XCS_TEST_FAILURE_COUNT=0
        #XCS_WARNING_CHANGE=0
        #XCS_WARNING_COUNT=0

        botName = ENV["XCS_BOT_NAME"]
        
        if !botName
            Helper.log.warn "We're not running in the context of an Xcode Bot. Nothing to do!"
            return
        end

        integrationResult = ENV["XCS_INTEGRATION_RESULT"]
        statusMessage = integrationResult

        if ENV["XCS_TESTS_CHANGE"].to_i > 0
            statusMessage = "Congratulations! New tests added to bot #{botName}!"
        end

        if ENV["XCS_TESTS_COUNT"].to_i == 0
            statusMessage = "Warning! '#{botName}' has no tests."
        end

        if ENV["XCS_TEST_FAILURE_CHANGE"].to_i > 0
            statusMessage = "Danger! You broke tests in bot #{botName}"
        end

        if ENV["XCS_TEST_FAILURE_CHANGE"].to_i < 0
            statusMessage = "Awesome! You fixed tests in bot #{botName}" if ENV["XCS_TEST_FAILURE_CHANGE"].to_i > 1
            statusMessage = "Outstanding! You fixed tests in bot #{botName}" if ENV["XCS_TEST_FAILURE_CHANGE"].to_i > 5
            statusMessage = "Megakill! You fixed tests in bot #{botName}" if ENV["XCS_TEST_FAILURE_CHANGE"].to_i > 10
            statusMessage = "Ultrakillllll! You fixed tests in bot #{botName}" if ENV["XCS_TEST_FAILURE_CHANGE"].to_i > 50
        end

        if ENV["XCS_ERROR_CHANGE"].to_i > 0
            statusMessage = "Danger! There were build errors in bot #{botName}"
        end

        if statusMessage
            Fastlane::Actions::XsayAction.run(statusMessage)
        end

        # Todo: deliver the Bot stats for coverage and tests
        slackMessage = statusMessage ? "Xcode Bot Completed: #{statusMessage}" : "Xcode Bot Completed"
        slackArgs = Fastlane::ConfigurationHelper.parse(Fastlane::Actions::SlackAction, {
          message: slackMessage,
          success: integrationResult == "succeeded" ? true : false
        })
        
        Fastlane::Actions::SlackAction.run(slackArgs)

      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Announces Xcode Bot build status"
      end

      def self.details
        "This will broadcast the result of Xcode Bot builds in the manner you see fit."
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
#        [
#          FastlaneCore::ConfigItem.new(key: :api_token,
#                                       env_name: "FL_XCODE_BOT_STATUS_API_TOKEN", # The name of the environment variable
#                                       description: "API Token for XcodeBotStatusAction", # a short description of this parameter
#                                       verify_block: proc do |value|
#                                          raise "No API token for XcodeBotStatusAction given, pass using `api_token: 'token'`".red unless (value and not value.empty?)
#                                          # raise "Couldn't find file at path '#{value}'".red unless File.exist?(value)
#                                       end),
#          FastlaneCore::ConfigItem.new(key: :development,
#                                       env_name: "FL_XCODE_BOT_STATUS_DEVELOPMENT",
#                                       description: "Create a development certificate instead of a distribution one",
#                                       is_string: false, # true: verifies the input is a string, false: every kind of value
#                                       default_value: false) # the default value if the user didn't provide one
#        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
#          ['XCODE_BOT_STATUS_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["marcpalmer"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end


