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
    def initialize(name)
      @name = name
    end

    def message
      "Expect config of '#{@name}' was unset"
    end
  end
end
