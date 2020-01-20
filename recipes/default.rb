if node[:platform].include?('debian') and node[:platform_version].include?('8.')
  include_recipe 'shorewall_ng::shorewall5_jessie_fix'
end

package 'shorewall' do
  action :install
end

include_recipe 'shorewall_ng::config'
