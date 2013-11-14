include_recipe "scribe::install"

template "/usr/local/scribe/scribe.conf" do
    action :create
    source "endpoint.conf.erb"
    variables({
    })
    notifies :restart, "service[scribed]", :immediately
end
