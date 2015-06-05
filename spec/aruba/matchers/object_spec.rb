require 'spec_helper'

RSpec.describe 'Path Matchers' do
  include_context 'uses aruba API'

  def expand_path(*args)
    @aruba.expand_path(*args)
  end

  describe '#to_have_size' do
    let(:obj) { 'string' }

    context 'when has size' do
      context 'when is string' do
        it { expect(obj).to have_size 6 }
      end

      context 'when is file' do
        let(:obj) { @file_name }

        before :each do
          File.write(@file_path, 'a')
        end

        it { expect(obj).to have_size 1 }
      end

      context 'when has size' do
        let(:obj) do
          Class.new do
            def nil?
              false
            end

            def empty?
              false
            end

            def size
              1_000
            end
          end.new
        end

        it { expect(obj).to have_size(1_000) }
      end
    end

    context 'when does not have size' do
      let(:obj) do
        Class.new do
          def nil?
            false
          end

          def empty?
            false
          end
        end.new
      end

      it { expect(obj).to have_size(-1) }
    end
  end
end