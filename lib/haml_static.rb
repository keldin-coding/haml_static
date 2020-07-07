# frozen_string_literal: true

require 'haml_static/version'
require 'haml_static/configuration'
require 'haml_static/engine'

# :nodoc:
module HamlStatic
  # Base error for any wrapped errors
  class Error < StandardError; end

  # Error for managing a missing configuration value
  class MissingConfigError < Error
    # :nodoc:
    def initialize(name)
      @name = name
    end

    # :nodoc:
    def message
      "Expect config of '#{@name}' was unset"
    end
  end

  # Error for when a directory unexpectedly exists
  class DirectoryExists < Error
    # :nodoc:
    def initialize(name)
      @name = name
    end

    # :nodoc:
    def message
      "Directory of '#{@name}' already exists"
    end
  end
end
