# frozen_string_literal: true

require "test_helper"

module Openweathermap
  class TestSdk < Minitest::Test
    def setup
      @client_by_name = Openweathermap::Sdk::Client.new({ city_name: "Sao Jose do Rio Preto" })
      @client_by_id = Openweathermap::Sdk::Client.new({ city_id: 3_457_095 })
    end

    def test_that_it_has_a_version_number
      refute_nil ::Openweathermap::Sdk::VERSION
    end

    def test_that_it_be_valid
      assert true, @client_by_name.valid?
      assert true, @client_by_id.valid?
    end

    def test_that_it_has_json_response
      assert true, @client_by_name.forecast_response.is_a?(Hash)
      assert true, @client_by_id.weather_response.is_a?(Hash)
    end

    def test_that_it_got_a_raise_if_not_have_key
      old_env = ENV.to_hash
      ENV.delete("OPENWEATHERMAP_KEY")
      @new_client = ::Openweathermap::Sdk::Client.new({ city_name: "Campinas" })
      ENV.replace old_env
      assert_equal "Preencha o valor de OPENWEATHERMAP_KEY no arquivo .env para continuar!", @new_client.error.message
    end

    def test_that_it_got_a_raise_if_not_city_param
      @new_client = ::Openweathermap::Sdk::Client.new
      assert_equal "Informe os parametros city_id ou city_name!", @new_client.error.message
      assert true, @new_client.weather_response.nil?
      assert true, @new_client.forecast_response.nil?
    end
  end
end
