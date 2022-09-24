# frozen_string_literal: true

require_relative "sdk/version"

module Openweathermap
  module Sdk
    require "dotenv/load"
    OPENWEATHERMAP_KEY =
    class Error < StandardError; end

    class Client
      attr_reader :error
      def initialize(city_name=nil)
        @open_weather_map_key = ENV["OPENWEATHERMAP_KEY"]
        @city_name = city_name
        valid?
      end

      def valid?
        return false unless have_a_key?
        return false unless have_a_city_name?
        true
      end

      def print_key
        puts @open_weather_map_key
      end

      private

      def have_a_key?
        return true unless @open_weather_map_key.nil?

        @error = ArgumentError.new("Preencha o valor de OPENWEATHERMAP_KEY no arquivo .env para continuar!")
        false
      end

      def have_a_city_name?
        return true unless @city_name.nil?

        @error = ArgumentError.new("Informe o nome da cidade!")
        false
      end
    end
  end
end
