# frozen_string_literal: true

require 'haml_static/configuration'
require 'haml_static/directory_manager'
require 'haml_static/generator'
require 'haml_static/view_loader'

module HamlStatic
  # Handles all parts of generation for a project
  class Engine
    # @return HamlStatic::Configuration
    attr_reader :config

    # @param config [HamlStatic::Configuration] configuration for handling the
    #   project.
    def initialize(config)
      @config = config

      @dir_manager = DirectoryManager.new(config)
    end

    # The sequence of steps for generating all the HTML for a project. This
    # is effectively calling out to all the helper classes that help this be a
    # a simple, declarative run.
    def run
      @dir_manager.clean_destination
      @dir_manager.create_destination
    end
  end
end
