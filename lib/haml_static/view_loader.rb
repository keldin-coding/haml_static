# frozen_string_literal: true

module HamlStatic
  # Simple object for loading all the available view files
  class ViewLoader
    # Pattern that all view files should be written in.
    PATTERN = '**/*_view.rb'

    # Attempts to require any files matching the View pattern and loads them.
    def self.load
      Dir.glob(PATTERN).each do |f|
        require File.join(Dir.pwd, f)
      end
    end
  end
end
