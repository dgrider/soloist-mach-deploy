execute "Disable menu bar transparency" do
  # from http://knoopx.net/2011/10/28/os-x-lion-tweaks
  command "defaults write -g AppleEnableMenuBarTransparency -bool false"
end
