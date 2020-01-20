if node[:platform].start_with?('debian') and node[:platform_version].start_with?('8')
  include_recipe 'shorewall_ng::shorewall5_jessie_fix'
end

package 'shorewall' do
  action :install
end

include_recipe 'shorewall_ng::config'
