#
# Cookbook:: tomcat
# Recipe:: packages
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'java-1.8.0-openjdk-devel' do
  action :install
end

group 'tomcat'

user 'tomcat' do
  group 'tomcat'
  manage_home false
  shell '/bin/nologin'
  home '/opt/tomcat'
end

directory '/opt/tomcat' do
  action :create
  group 'tomcat'
end

remote_file '/tmp/apache-tomcat-9.0.0.M17.tar.gz' do
  source 'http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.0.M17/bin/apache-tomcat-9.0.0.M17.tar.gz'
end

execute 'extract tomcat binary' do
  command 'tar -xzf apache-tomcat-9.0.0.M17.tar.gz --strip 1 -C /opt/tomcat/'
  cwd '/tmp/'
  only_if { File.exists?("/tmp/apache-tomcat-9.0.0.M17.tar.gz")}
end

# TODO: NOT DESIRED STATE
execute 'chgrp -R tomcat /opt/tomcat'

execute 'chown -R tomcat /opt/tomcat'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

# service 'tomcat' do
#   action [:start, :enable]
# end

# TODO: NOT DESIRED STATE
# execute 'chmod g+r conf/*'

# TODO: NOT DESIRED STATE
# execute 'chown -R tomcat webapp/ work/ temp/ logs/'
