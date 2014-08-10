# FIXME: This should be re-factored once package.rb has a mechanism
# for installing pkg files without mounting a dmg
include_recipe "sprout-base::addloginitem"

app_path="/Applications/Flycut.app"

ruby_block "Install Flycut" do
  block do
    system("cd #{Chef::Config[:file_cache_path]}/ && curl -OL https://github.com/downloads/TermiT/Flycut/flycut1.5.pkg")
    system("installer -allowUntrusted -package  #{Chef::Config[:file_cache_path]}/flycut1.5.pkg -target /")
    system("chown -R #{node['current_user']} #{app_path}")
    # oh ugly hack, how I abhor thee!
    system("su #{node['current_user']} -c \"addloginitem #{app_path}\"")
  end
  not_if {File.exists?(app_path)}
end

ruby_block "test that Flycut install worked" do
  block do
    raise "Flycut install failed!" if ! File.exists?(app_path)
  end
end
