# frozen_string_literal: true

require 'yaml'
require 'thor'
require 'haml_static/generator'
require 'haml_static/cli/configuration'

module HamlStatic
  # CLI for operating HamlStatic from the command line
  class CLI < Thor
    # desc 'generate', 'Generates HTML from the HAML directory'
    # option :source,
    #        aliases: :s,
    #        default: 'src',
    #        desc: 'Directory name, relative to the current directory, where the HAML exists'
    # option :destination,
    #        aliases: :d,
    #        default: 'site',
    #        desc: 'Directory name, relative to the current directory, where the generated HTML will go'
    # def generate
    #   HamlStatic::generator.new(
    #     source: options[:source],
    #     destination: options[:destination]
    #   )
    # end
    desc 'configure OPTION VALUE', 'Allow configuring HamlStatic options for future usage'
    def configure(option_key, option_value)
      options = begin
        YAML.safe_load(File.read('./.haml_static.yml')) {}
                rescue Errno::ENOENT
                  {}
      end

      options[option_key] = option_value

      puts "Configured option '#{option_key}' with value: #{option_value}"

      File.open('./.haml_static.yml', 'w') { |f| f.puts YAML.dump(options) }
    end
  end
end
