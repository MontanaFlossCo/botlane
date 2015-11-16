module Fastlane
  module Actions
    class XsayAction < Action

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :message,
                                       is_string: true,
                                       description: "The message to speak"),
          FastlaneCore::ConfigItem.new(key: :voice,
                                       env_name: "XSAY_VOICE",
                                       description: "The voice to use",
                                       is_string: true)
        ]
      end



      def self.run(params)
        text = params[:message] if params.kind_of?(Hash)
        if text
            text = text.to_s
            voice = params[:voice]
        else
            text = params.join(' ') if params.kind_of?(Array) # that's usually the case
            text = params if params.kind_of?(String)
            
            voice = ENV["XSAY_VOICE"]
        end
  
        raise "You can't call the `say` action as OneOff" unless text
        
        text = text.tr("'", '"')
        
        Actions.sh(voice ? "say -v #{voice} #{text}" : "say '#{text}'")
      end

      def self.description
        "This action speaks out loud the given text, with an option to specify `voice` and `message`"
      end

      def self.is_supported?(platform)
        true
      end

      def self.author
        "marcpalmer"
      end
    end
  end
end