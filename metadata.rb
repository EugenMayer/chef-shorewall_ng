name 'shorewall_ng'
maintainer 'Eugen Mayer'
maintainer_email 'eugen.mayer@kontextwork.de'
license 'Apache 2.0'
description 'Configures and install Shorewall 4 and 5'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'shorewall_ng', 'Configures and install Shorewall 4 and 5'

%w{ debian ubuntu }.each do |os|
  supports os
end

depends 'apt'
