require_relative 'helpers'

module Capistrano
  module Messaging
    class Telegram
      include Helpers

      extend Forwardable
      def_delegators :env, :fetch

      def rocket
        '%F0%9F%9a%80'
      end

      # def bang
      #   '%E2%80%BC%EF%B8%8F'
      # end

      def robo
        '%F0%9F%A4%96'
      end

      def payload_for_updating
        {
          text: "#{robo} #{deployer} has started deploying branch #{branch} of #{application} to #{stage}"
        }
      end

      def payload_for_reverting
        {
          text: "#{robo} #{deployer} has started rolling back branch #{branch} of #{application} to #{stage}"
        }
      end

      def payload_for_updated
        {
          text: "#{rocket} #{deployer} has finished deploying branch #{branch} of #{application} to #{stage}"
        }
      end

      def payload_for_reverted
        {
          text: "#{robo} #{deployer} has finished rolling back branch of #{application} to #{stage}"
        }
      end

      def payload_for_failed
        {
          text: "#{robo} #{deployer} has failed to #{deploying? ? 'deploy' : 'rollback'} branch #{branch} of #{application} to #{stage}"
        }
      end

      def payload_for(action)
        method = "payload_for_#{action}"
        respond_to?(method) && send(method)
      end

    end
  end
end