require 'spec_helper'

RSpec.describe 'Directory Matchers' do
  include_context 'uses aruba API'

  def expand_path(*args)
    @aruba.expand_path(*args)
  end

  describe 'to_be_existing_directory' do
    let(:name) { 'test.d' }
    let(:path) { File.join(@aruba.current_directory, name) }

    context 'when directory exists' do
      before :each do
        FileUtils.mkdir_p path
      end

      it { expect(name).to be_existing_directory }
    end

    context 'when directory does not exist' do
      it { expect(name).not_to be_existing_directory }
    end
  end

  describe 'to_have_sub_directory' do
    let(:name) { 'test.d' }
    let(:path) { File.join(@aruba.current_directory, name) }
    let(:content) { %w(subdir.1.d subdir.2.d) }

    context 'when directory exists' do
      before :each do
        FileUtils.mkdir_p path
      end

      before :each do
        Array(content).each { |p| Dir.mkdir File.join(path, p) }
      end

      context 'when single directory' do
        it { expect(name).to have_sub_directory('subdir.1.d') }
      end

      context 'when multiple directories' do
        it { expect(name).to have_sub_directory(['subdir.1.d', 'subdir.2.d']) }
      end

      context 'when non existing directory' do
        it { expect(name).not_to have_sub_directory('subdir.3.d') }
      end
    end

    context 'when directory does not exist' do
      it { expect(name).not_to have_sub_directory('subdir') }
    end
  end
end
