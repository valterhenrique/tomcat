# # encoding: utf-8

# Inspec test for recipe tomcat::packages

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'java-1.8.0-openjdk-devel' do
  it { should be_installed }
end

describe file('/opt/tomcat') do
  it { should exist }
  it { should be_directory }
end

describe file('/opt/tomcat/conf') do
  it { should exist }
  it { should be_mode 70 }
end

%w{ conf webapps work temp logs }.each do |path|
  describe file("/opt/tomcat/#{path}") do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end
end
