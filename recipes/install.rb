include_recipe 'build-essential'
include_recipe 'apt'

package "libtool"
package "libevent-dev"
package "pkg-config"
package "libssl-dev"
package "libboost-all-dev"
package "libbz2-dev"
package "python-dev"
package "git"

gem "bundler"

git "#{Chef::Config[:file_cache_path]}/thrift" do
    repository "https://github.com/apache/thrift.git"
    reference "master"
    action :sync
end

bash "install thrift" do 
    cwd "#{Chef::Config[:file_cache_path]}/thrift"
    code <<-EOH
    ./bootstrap.sh
    ./configure --without-ruby
    make
    make install
    EOH
    not_if { ::File.exists?('/usr/local/bin/thrift') }
end 

bash "install thrift python" do
    cwd "#{Chef::Config[:file_cache_path]}/thrift/lib/py"
    code <<-EOH
    python setup.py install
    EOH
    not_if { Process.waitpid2(IO.popen(['python', '-c', 'import thrift', :err=>File.new('/dev/null','w')]).pid)[1].exitstatus == 0 }
end

bash "install fb303" do 
    cwd "#{Chef::Config[:file_cache_path]}/thrift/contrib/fb303"
    code <<-EOH
    ./bootstrap.sh
    ./configure CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H" --without-ruby
    make
    make install
    ldconfig
    EOH
    not_if { ::File.exists?('/usr/local/lib/libfb303.a') }
end

bash "install fb303 python" do
    cwd "#{Chef::Config[:file_cache_path]}/thrift/contrib/fb303/py"
    code <<-EOH
    sudo python setup.py install
    EOH
    not_if { Process.waitpid2(IO.popen(['python', '-c', 'import fb303', :err=>File.new('/dev/null','w')]).pid)[1].exitstatus == 0 }
end 

git "#{Chef::Config[:file_cache_path]}/scribe" do
    repository "https://github.com/facebook/scribe.git"
    reference "master"
    action :sync
end

bash "install scribe" do
    cwd "#{Chef::Config[:file_cache_path]}/scribe"
    code <<-EOH
    ./bootstrap.sh
    ./configure CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H -DBOOST_FILESYSTEM_VERSION=2" LIBS="-lboost_system -lboost_filesystem"
    make
    make install
    EOH
    not_if { ::File.exists?('/usr/local/bin/scribed') }
end

bash "install scribe python" do
    cwd "#{Chef::Config[:file_cache_path]}/scribe/lib/py"
    code <<-EOH
    sudo python setup.py install
    EOH
    not_if { Process.waitpid2(IO.popen(['python', '-c', 'import scribe', :err=>File.new('/dev/null','w')]).pid)[1].exitstatus == 0 }
end

# create directory for scribe.conf
directory '/usr/local/scribe' do
    action :create
end

# upstart
cookbook_file "/etc/init/scribed.conf" do
    action :create
    mode "644"
end

service "scribed" do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :reload => true, :restart => true
    action :enable
end
