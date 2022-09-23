# frozen_string_literal: true

require_relative "sdk/version"

module Openweathermap
  module Sdk
    require 'dotenv/load'
    OPENWEATHERMAP_KEY = ENV['OPENWEATHERMAP_KEY']
    class Error < StandardError; end
    class Consult
      # Dotenv.load
      def initialize
        puts "inicializando!!!"
        print_key
      end

      def print_key
        puts OPENWEATHERMAP_KEY
      end
    end
  end
end
