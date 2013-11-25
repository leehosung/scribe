require './specs/spec_helper'

describe 'scribe::install' do
    let(:chef_run)  { ChefSpec::Runner.new }

    it 'install scribe' do
        chef_run.converge(described_recipe)
        expect(chef_run).to create_directory('/usr/local/scribe')
        expect(chef_run).to create_cookbook_file('/etc/init/scribed.conf')
        expect(chef_run).to enable_service('scribed')
    end
end
