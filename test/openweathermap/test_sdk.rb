# frozen_string_literal: true

require "test_helper"

class Openweathermap::TestSdk < Minitest::Test
  def setup
    @client = Openweathermap::Sdk::Client.new('Sao Jose do Rio Preto')
  end

  def test_that_it_has_a_version_number
    refute_nil ::Openweathermap::Sdk::VERSION
  end

  def test_that_it_be_valid
    assert true, @client.valid?
  end

  def test_that_it_got_a_raise_if_not_have_key
    old_env = ENV.to_hash
    ENV.delete("OPENWEATHERMAP_KEY")
    @new_client = ::Openweathermap::Sdk::Client.new('Campinas')
    assert_equal "Preencha o valor de OPENWEATHERMAP_KEY no arquivo .env para continuar!",  @new_client.error.message
    ENV.replace old_env
  end

  def test_that_it_got_a_raise_if_not_city_name_param
    @new_client = ::Openweathermap::Sdk::Client.new
    assert_equal "Informe uma cidade !!!",  @new_client.error.message
  end

end
