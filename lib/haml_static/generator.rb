# frozen_string_literal: true

require 'fileutils'

module HamlStatic
  # Used for generating the HTML file
  class Generator
    # @return HamlStatic::Configuration
    attr_reader :config

    # @param config [HamlStatic::Configuration] configuration for handling the
    #   new generator.
    def initialize(config)
      @config = config
    end

    def generate
      cleanup(config.destination)
    end

    private

    def cleanup(destination)
      FileUtils.rm_r(File.join(Dir.pwd, destination))
    rescue Errno::ENOENT
      puts "No pre-existing directory found for #{destination}"
    end
  end
end
