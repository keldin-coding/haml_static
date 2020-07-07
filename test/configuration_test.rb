# frozen_string_literal: true

require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_init_succeeds_with_no_file
    teardown # Explicitly call the teardown method becaues it cleans up any leftover files

    config = HamlStatic::Configuration.new

    assert_equal 'src', config.source
    assert_equal 'site', config.destination
  end

  def test_init_succeeds_with_default_file
    setup_file

    config = HamlStatic::Configuration.new

    assert_equal 'source', config.source
    assert_equal 'destination', config.destination
  end

  def test_init_uses_provided_hash_overrides_file
    setup_file

    config = HamlStatic::Configuration.new(source: 'amazing')

    assert_equal 'amazing', config.source
    assert_equal 'destination', config.destination
  end

  def test_init_uses_provided_hash_with_no_file_works
    teardown

    config = HamlStatic::Configuration.new(destination: 'amazing')

    assert_equal 'src', config.source
    assert_equal 'amazing', config.destination
  end

  def test_raises_error_on_usage_if_source_unset
    config = HamlStatic::Configuration.new(source: nil)

    assert_raises HamlStatic::MissingConfigError do
      config.source
    end
  end

  def test_raises_error_on_usage_if_destination_unset
    config = HamlStatic::Configuration.new(destination: nil)

    assert_raises HamlStatic::MissingConfigError do
      config.destination
    end
  end

  # rubocop:disable Lint/SuppressedException
  def teardown
    File.delete('./.haml_static.yml')
  rescue Errno::ENOENT
  end
  # rubocop:enable Lint/SuppressedException

  private

  def setup_file
    File.open('./.haml_static.yml', 'w+') do |f|
      f.puts YAML.dump('source' => 'source', 'destination' => 'destination')
    end
  end
end
