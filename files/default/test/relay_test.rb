require 'minitest/spec'

# reference : https://github.com/calavera/minitest-chef-handler/blob/v0.4.0/examples/spec_examples/files/default/tests/minitest/example_test.rb

describe_recipe 'scribe::relay' do
    describe 'sets remote_host to value from attribute' do
	it { file("/usr/local/scribe/scribe.conf").must_include 'remote_host=127.1.2.3' }
    end
end
