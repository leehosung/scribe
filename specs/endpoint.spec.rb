require './specs/spec_helper'

describe 'scribe::endpoint' do
    let(:chef_run)  { ChefSpec::Runner.new }

    it 'run as a endpoint' do
        chef_run.converge(described_recipe)
        expect(chef_run).to create_template('/usr/local/scribe/scribe.conf')
        resource = chef_run.template('/usr/local/scribe/scribe.conf')
        expect(resource).to notify('service[scribed]').to(:restart)
    end
end
