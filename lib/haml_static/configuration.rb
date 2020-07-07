# frozen_string_literal: true

require 'yaml'

module HamlStatic
  # Manages configuration as needed for the HamlStatic gem
  class Configuration
    # Store the Default Config as a Hash constant so we can differentiate
    # between passed in default config and no provided config.
    DEFAULT_CONFIG = { source: 'src', destination: 'site' }.freeze
    # By default, loads from .haml_static.yml and uses the Hash passed to the
    # initializer otherwise.
    #
    # Possible configuration values are:
    # :source - the directory where all HAML and .rb files live for the static
    # site
    # :destination - the directory where the generated HTML will be written
    #
    # @param given [Hash] Base default values to be used. Defaults to an empty
    #   Hash.
    # rubocop:disable Lint/SuppressedException
    def initialize(given = {})
      config = DEFAULT_CONFIG.dup

      begin
        read = YAML.safe_load(File.read('./.haml_static.yml'), symbolize_names: true)
        config.merge!(read)
      rescue Errno::ENOENT
      end

      config.merge!(given)

      @config = config.slice(:source, :destination)
    end
    # rubocop:enable Lint/SuppressedException

    # @return String the location configured for where the HAML and .rb files
    #   live. Defaults to 'src'
    # @raise HamlStatic::MissingConfigError if the configuration is purposefully
    #   unset
    def source
      source = @config[:source].to_s

      raise HamlStatic::MissingConfigError, :source if source.empty?

      source
    end

    # @return String the directory where the generated HTML will be written.
    #   Defaults to 'site'
    # @raise HamlStatic::MissingConfigError if the configuration is purposefully
    #   unset
    def destination
      destination = @config[:destination].to_s

      raise HamlStatic::MissingConfigError, :destination if destination.empty?

      destination
    end
  end
end
