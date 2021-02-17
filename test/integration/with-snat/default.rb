# we should have a masq file
describe file('/etc/shorewall/snat') do
  it { should be_file }
  its('content') { should match(/^SNAT\(206\.124\.146\.177\).*172\.20\.1\.0/) }
end
