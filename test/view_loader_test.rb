# frozen_string_literal: true

# rubocop:disable Style/GlobalVars

require 'test_helper'
require 'fileutils'

class ViewLoaderTest < Minitest::Test
  def test_load_requires_files
    # This is a hacky way of verifying only the expected files were required.
    $hacky_test = 0

    # rubocop:disable Lint/SuppressedException
    begin
      FileUtils.rm_r(File.join(Dir.pwd, 'subviews'))
    rescue Errno::ENOENT
    end
    # rubocop:enable Lint/SuppressedException

    Dir.mkdir('subviews')
    # Would indicate incorrect _view part of the pattern
    File.open('unknown.rb', 'w+') { |f| f.puts '$hacky_test += 100' }

    # Would indicate non .rb part of the pattern
    File.open('some-text.txt', 'w+') { |f| f.puts 'this is invalid Ruby' }
    File.open('first_view.rb', 'w+') { |f| f.puts '$hacky_test += 1' }
    File.open('subviews/second_view.rb', 'w') { |f| f.puts '$hacky_test += 1' }

    HamlStatic::ViewLoader.load

    assert_equal 2, $hacky_test

    $hacky_test = 0
    FileUtils.rm_r(File.join(Dir.pwd, 'subviews'))
    File.delete('unknown.rb', 'first_view.rb', 'some-text.txt')
  end
end

# rubocop:enable Style/GlobalVars
