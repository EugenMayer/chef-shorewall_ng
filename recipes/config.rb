#
# Author:: Eugen Mayer <eugen.mayer@kontextwork.de>
# Author:: Claudio Cesar Sanchez Tejeda <demonccc@gmail.com>
# Cookbook Name:: shorewall_ng
# Recipe:: config
#
# Copyright:: 2017, Eugen Mayer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'set'

enabled=(node['shorewall']['enabled'] ? 1 : 0 )

%w{ hosts interfaces policy rules zones tunnels masq }.each do |conf_file|
  template "/etc/shorewall/#{conf_file}" do
    source "#{conf_file}.erb"
    mode 0600
    owner "root"
    group "root"
    notifies :restart, "service[shorewall]", :delayed
  end
end

if node[:platform].include?('debian') and node[:platform_version].include?('9.')
  # debian stretch is yet 5.0 based, so use the old configuration
  template '/etc/shorewall/shorewall.conf' do
    source 'shorewall5.0.conf.erb'
    notifies :restart, "service[shorewall]", :delayed
  end
else
  # else, assume the newest
  template '/etc/shorewall/shorewall.conf' do
    source 'shorewall5.1plus.conf.erb'
    notifies :restart, "service[shorewall]", :delayed
  end
end


template '/etc/default/shorewall' do
  source 'default.erb'
  variables( 
    :startup => enabled,
    :default => node['shorewall']['default']
  )
  notifies :restart, "service[shorewall]", :delayed
end

service "shorewall" do
  supports [ :status, :restart ]
  if node['shorewall']['enabled']
    action [:start, :enable]
  else
    action [:stop, :disable]
  end
end
