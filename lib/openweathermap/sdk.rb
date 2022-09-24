# frozen_string_literal: true

require_relative "sdk/version"
# Module Openweathermap
module Openweathermap
  # Module Sdk
  # Conjunto de comandos para consulta de temperatura no OpenWeatherMap
  module Sdk
    require "dotenv"
    Dotenv.load(".env", ".env.test")
    class Error < StandardError; end

    URL_BASE = "https://api.openweathermap.org/data/2.5/forecast"
    # Classe Cliente
    class Client
      attr_reader :error, :json_response_body

      def initialize(options = {})
        @open_weather_map_key = ENV.fetch("OPENWEATHERMAP_KEY", nil)
        @city_name = options.fetch(:city_name, nil)
        @lang = options.fetch(:lang, "pt_br")
        perform_request
      end

      def uri
        URI("#{URL_BASE}?q=#{@city_name}&lang=#{@lang}&appid=#{@open_weather_map_key}&units=metric")
      end

      require "net/http"
      require "json"
      def perform_request
        return nil unless valid?

        response = Net::HTTP.get_response(uri)
        @json_response_body = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
      end

      def valid?
        return false unless key_present?
        return false unless city_name_present?

        true
      end

      def print_key
        puts @open_weather_map_key
      end

      private

      def key_present?
        return true unless @open_weather_map_key.nil?

        @error = ArgumentError.new("Preencha o valor de OPENWEATHERMAP_KEY no arquivo .env para continuar!")
        false
      end

      def city_name_present?
        return true unless @city_name.nil?

        @error = ArgumentError.new("Informe o nome da cidade!")
        false
      end
    end
  end
end
