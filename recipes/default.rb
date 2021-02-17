package 'shorewall' do
  action :install
end

include_recipe 'shorewall_ng::config'
