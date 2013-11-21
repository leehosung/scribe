require 'minitest/spec'

# reference : https://github.com/calavera/minitest-chef-handler/blob/v0.4.0/examples/spec_examples/files/default/tests/minitest/example_test.rb

describe_recipe 'scribe::install' do
    describe 'services' do
        it "run as a daemon" do
            service("scribed").must_be_running
        end
        it "boots on startup" do
            service("scribed").must_be_enabled
        end 
    end
end
