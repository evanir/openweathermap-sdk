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
      attr_reader :error, :forecast_response, :weather_response

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
        @forecast_response = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
      end

      def perform_weather_request
        return nil unless valid?

        response = Net::HTTP.get_response(weather_uri)
        @weather_response = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
      end

      def valid?
        return false unless key_present?
        return false unless city_param_present?

        true
      end

      def current_weather
        return nil if @weather_response.nil?

        @weather_response["weather"][0]
      end

      def summary_forecast
        return nil if forecast_response.nil?
        return @summary_forecast unless @summary_forecast.nil?

        @summary_forecast = {}
        @forecast_response["list"].each_with_index do |list|
          full_date = Date.parse(list["dt_txt"])
          short_date = "#{full_date.day}/#{full_date.month}"
          next if short_date == today_s

          @summary_forecast[short_date] ||=[]
          @summary_forecast[short_date] << list["main"]["temp"]
        end
        @summary_forecast
      end

      def average_summary
        return @average_summary unless @average_summary.nil?

        @average_summary = {}
        summary_forecast.each do |day, temp|
          @average_summary[day] = (temp.sum / temp.size).round(2)

        end
        @average_summary
      end

      def summary_text
        "#{weather_response['main']['temp'].to_i}ºC e #{current_weather['description']}"\
         " em #{weather_response['name']} em #{today_s}. Média para os próximos dias: #{average_text}"
      end

      def average_text
        return @average_text unless @average_text.nil?

        @average_text = ''
        c = 0
        average_summary.each do |day, avg|
          @average_text += "#{avg.to_i}ºC em #{day}"
          c+=1
          @average_text += (c == average_summary.size) ? "." : ", "
        end
        @average_text
      end

      def today_s
        "#{Date.today.day}/#{Date.today.month}"
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
