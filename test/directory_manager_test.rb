# frozen_string_literal: true

require 'test_helper'

class DirectoryManagerTest < Minitest::Test
  def test_cleanup_destination_succeeds
    dir_manager = HamlStatic::DirectoryManager.new(config)
    file_path = File.join(Dir.pwd, config.destination)

    Dir.mkdir(file_path)
    assert File.exist?(file_path), 'Failed to create directory to prep for test'

    dir_manager.clean_destination
    refute File.exist?(file_path), 'Did not remove directory as expected'
  end

  def test_cleanup_destination_does_not_fail_if_dir_does_not_exist
    dir_manager = HamlStatic::DirectoryManager.new(config)
    file_path = File.join(Dir.pwd, config.destination)

    refute File.exist?(file_path), 'File should not exist in prep for test'

    assert_output(/No pre-existing directory found for destination/) do
      dir_manager.clean_destination
    end

    refute File.exist?(file_path), 'File continue to not exist'
  end

  def test_create_destination_succeeds
    dir_manager = HamlStatic::DirectoryManager.new(config)
    file_path = File.join(Dir.pwd, config.destination)

    dir_manager.create_destination

    assert File.exist?(file_path), 'Failed to create directory'
  end

  def test_create_destination_raises_if_directory_exists
    dir_manager = HamlStatic::DirectoryManager.new(config)
    file_path = File.join(Dir.pwd, config.destination)

    Dir.mkdir(file_path)
    assert File.exist?(file_path), 'Failed to create directory to prep for test'

    error = assert_raises HamlStatic::DirectoryExists do
      dir_manager.create_destination
    end

    assert_match(/Directory of '#{config.destination}' already exists/, error.message)
  end

  # rubocop:disable Lint/SuppressedException
  def setup
    FileUtils.rm_r(File.join(Dir.pwd, config.destination))
  rescue Errno::ENOENT
  end

  def teardown
    setup
  end
  # rubocop:enable Lint/SuppressedException

  private

  def config
    @config ||= HamlStatic::Configuration.new
  end
end
