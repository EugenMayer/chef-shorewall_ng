name 'shorewall_ng'
maintainer 'Eugen Mayer'
maintainer_email 'eugen.mayer@kontextwork.de'
license 'Apache 2.0'
description 'Configures and install Shorewall 5'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.4.0'

recipe 'shorewall_ng', 'Configures and install Shorewall 5'

%w{ debian ubuntu }.each do |os|
  supports os
end

depends 'apt'

source_url 'https://github.com/EugenMayer/chef-shorewall_ng'
issues_url 'https://github.com/EugenMayer/chef-shorewall_ng/issues'
