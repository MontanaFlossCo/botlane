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
                                       optional: true,
                                       description: "The voice to use",
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :dont_speak,
                                       env_name: "XSAY_DONTSPEAK",
                                       is_string: false,
                                       description: "Set to true to suppress all speech",
                                       optional: true,
                                       verify_block: proc do |value|
                                         raise "Please pass a valid value for dont_speak. Use one of the following: true, false" unless value.kind_of?(TrueClass) || value.kind_of?(FalseClass)
                                       end)
        ]
      end
 


      def self.run(params)
        dontSpeak = ENV["XSAY_DONTSPEAK"] == "true" ? true : false
        
        text = params[:message] if params.kind_of?(Hash)
        if text
            text = text.to_s
            voice = params[:voice]

            if params[:dont_speak]
              dontSpeak = params[:dont_speak]
            end
        else
            text = params.join(' ') if params.kind_of?(Array) # that's usually the case
            text = params if params.kind_of?(String)
            
            voice = ENV["XSAY_VOICE"]
        end

        return if dontSpeak

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