include_recipe "scribe::install"

template "/usr/local/scribe/scribe.conf" do
    action :create
    source "relay.conf.erb"
    variables({
        :remote_host => node['scribe']['remote_host']
    })
    notifies :restart, "service[scribed]", :immediately
end
