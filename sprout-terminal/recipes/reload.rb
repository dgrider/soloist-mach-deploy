include_recipe 'sprout-terminal::check_for_active'

execute 'killall cfprefsd' do
  not_if { node['sprout']['terminal']['default_profile'].nil? }
end
