# frozen_string_literal: true

require 'fileutils'

module HamlStatic
  # Manages directories needed to be created and deleted for the project
  class DirectoryManager
    # @return HamlStatic::Configuration
    attr_reader :config

    # @param config [HamlStatic::Configuration] configuration for handling the
    #   project.
    def initialize(config)
      @config = config
    end

    # Removes the directory and all its contents found at the configured
    # destination directory
    #
    # @return void
    def clean_destination
      FileUtils.rm_r(File.join(Dir.pwd, config.destination))
    rescue Errno::ENOENT
      puts "No pre-existing directory found for destination '#{config.destination}'"
    end

    # Creates a directory for the configured destination
    def create_destination
      Dir.mkdir(File.join(Dir.pwd, config.destination))
    rescue Errno::EEXIST
      raise HamlStatic::DirectoryExists, config.destination
    end
  end
end
