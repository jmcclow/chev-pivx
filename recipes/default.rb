#
# Cookbook:: chef_node
# Recipe:: default
#
# Copyright:: 2017, Jay McClow, All Rights Reserved.

Chef::Log.debug("OMG: #{coin}")

cookbook_file "/tmp/#{node['chef_node']['tarball']}" do
  source "default/#{node['chef_node']['tarball']}"
  action :create
end

bash "extract #{coin}" do
  code <<-EOM
    tar xvfz /tmp/#{node['chef_node']['tarball']} -C /opt/
  EOM
end

link '/opt/pivx' do
  to "/opt/#{node['chef_node']['package']}"
end

directory "/home/vagrant/.#{coin}"

template "/home/vagrant/.#{coin}/#{coin}.conf" do
  source "default/#{coin}.conf.erb"
  action :create
end

directory "/root/.#{coin}"

template "/root/.#{coin}/#{coin}.conf" do
  source "default/#{coin}.conf.erb"
  action :create
end

bash "start #{coin}d" do
  user 'root'
  code <<-EOM
    /opt/#{coin}/bin/#{coin}d
  EOM
end
