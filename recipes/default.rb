# TODO: when apt_fix is implemented more generally include it here
node.default['shorewall']['version'] = 5
package 'shorewall' do
  action :install
end

include_recipe 'shorewall_ng::shorewall5_apt_fix'
include_recipe 'shorewall_ng::config'
