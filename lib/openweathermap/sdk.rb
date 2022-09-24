# frozen_string_literal: true

require_relative "sdk/version"

module Openweathermap
  module Sdk
    require "dotenv/load"
    OPENWEATHERMAP_KEY =
    class Error < StandardError; end

    class Client
      attr_reader :error
      def initialize(city_name)
        @open_weather_map_key = ENV["OPENWEATHERMAP_KEY"]
        @city_name = city_name
        puts "uso: Openweathermap::Sdk:Client.new('nome_cidade')" unless valid?
      end

      def valid?
        return false unless have_a_key?
        return false if @city_name.nil?
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

    end
  end
end
