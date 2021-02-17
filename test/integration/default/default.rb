# Inspec test for recipe shorewall_reloaded::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

shorewall_config_path = '/etc/shorewall/shorewall.conf'
options = {
  assignment_re: /^\s*([^=]*?)\s*=\s*(.*?)\s*$/
}
shorewall_config = parse_config_file(shorewall_config_path, options)

describe package('shorewall') do
  it { should be_installed }
end

describe package('shorewall') do
  it { should be_installed }
  its('version') { should(match(/^5\./)) }
end

describe file(shorewall_config_path) do
  its('content') { should include 'Shorewall Version 5' }
end

describe shorewall_config do
  its('DOCKER') { should eq 'Yes' }
  its('IP_FORWARDING') { should eq 'Yes' }
end

describe shorewall_config  do
  its('STARTUP_ENABLED') { should eq 'Yes' }
  its('LOGFILE') { should eq '/var/log/messages' }
  its('MULTICAST') { should eq 'No' }
  its('LOGFORMAT') { should eq '"Shorewall:%s:%s:"' }
  its('IP_FORWARDING') { should eq 'Yes' }
  its('LOG_MARTIANS') { should eq 'No' }
  its('LOGTAGONLY') { should eq 'No' }
  its('VERBOSITY') { should eq '1' }
end

# masq file should not be created since 0.6.0
describe file('/etc/shorewall/masq') do
  it { should_not be_file }
end
