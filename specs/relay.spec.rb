require './specs/spec_helper'

describe 'scribe::relay' do
    let(:chef_run)  { ChefSpec::Runner.new }

    it 'run as a realy' do
        chef_run.node.set['scribe']['remote_host'] = "127.1.2.3"
        chef_run.converge(described_recipe)
        expect(chef_run).to create_template('/usr/local/scribe/scribe.conf')
        expect(chef_run).to render_file('/usr/local/scribe/scribe.conf').with_content('remote_host=127.1.2.3')

        resource = chef_run.template('/usr/local/scribe/scribe.conf')
        expect(resource).to notify('service[scribed]').to(:restart)
    end
end
