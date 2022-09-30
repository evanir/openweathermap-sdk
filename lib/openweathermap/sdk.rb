# frozen_string_literal: true

require_relative "sdk/version"
# Module Openweathermap
module Openweathermap
  # Module Sdk
  # Conjunto de comandos para consulta de temperatura no OpenWeatherMap
  module Sdk
    require "dotenv/load"
    Dotenv.load(".env.test")
    class Error < StandardError; end

    URL_BASE = "https://api.openweathermap.org/data/2.5"
    # Classe Cliente
    class Client
      attr_reader :error, :forecast_response, :weather_response, :response

      def initialize(options = {})
        @open_weather_map_key = ENV.fetch("OPENWEATHERMAP_KEY", nil)
        @city_id   = options.fetch(:city_id, 0).to_i
        @city_name = options.fetch(:city_name, nil)
        @lang = options.fetch(:lang, "pt_br")
        perform_weather_request
        perform_forecast_request
      end

      def forecast_uri
        URI("#{URL_BASE}/forecast?#{query_str}&lang=#{@lang}&appid=#{@open_weather_map_key}&units=metric")
      end

      def weather_uri
        URI("#{URL_BASE}/weather?#{query_str}&lang=#{@lang}&appid=#{@open_weather_map_key}&units=metric")
      end

      def query_str
        @query_str = @city_id.zero? ? "q=#{@city_name}" : "id=#{@city_id}"
      end

      require "net/http"
      require "json"
      def perform_forecast_request
        return nil unless valid?

        response = Net::HTTP.get_response(forecast_uri)
        if response.is_a?(Net::HTTPSuccess)
          @forecast_response = JSON.parse(response.body)
        else
          @error = StandardError.new(response.body["message"])
        end
      end

      def perform_weather_request
        return nil unless valid?

        response = Net::HTTP.get_response(weather_uri)
        response_json = JSON.parse(response.body)

        if response.is_a?(Net::HTTPSuccess)
          @weather_response = response_json
        else
          @error = StandardError.new(response_json["message"])
        end
      end

      def valid?
        return false unless key_present?
        return false unless city_param_present?

        @error.nil?
      end

      def current_weather
        return nil if @weather_response.nil?

        @weather_response["weather"][0]
      end

      private

      def key_present?
        return true unless @open_weather_map_key.nil?

        @error = ArgumentError.new("Preencha o valor de OPENWEATHERMAP_KEY no arquivo .env para continuar!")
        false
      end

      def city_param_present?
        return true if !@city_name.nil? || @city_id.positive?

        @error = ArgumentError.new("Informe os parametros city_id ou city_name!")
        false
      end
    end
  end
end
