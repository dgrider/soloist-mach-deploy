#!/bin/bash
#
# YOU MUST HAVE XCODE and XCODE CLI installed for this to work!!
#

# Verify and install Ruby
pushd `pwd`
if rvm --version 2>/dev/null; then
  gem install soloist
else
  sudo gem install soloist
fi

# Create Setup Directory
mkdir -p ~/.setup; cd ~/.setup

# Create soloist run list
cat > soloistrc <<EOF
cookbook_paths:
- $PWD
recipes:
- sprout-base::var_chef_cache
- sprout-base::user_owns_usr_local
- sprout-base::homebrew
- sprout-osx-apps::homebrew_cask
- sprout-osx-settings::defaults_fast_key_repeat_rate
- sprout-osx-settings::enable_assistive_devices
- sprout-osx-settings::finder_display_full_path
- sprout-osx-settings::shared_memory
- sprout-osx-settings::locate
- sprout-osx-settings::menubar
- sprout-osx-settings::updates
- sprout-osx-settings::remove_expose_keyboard_shortcuts
- sprout-osx-settings::remove_garageband
- sprout-osx-settings::safari_preferences
- sprout-osx-settings::set_finder_show_hd_on_desktop
- sprout-osx-settings::set_finder_show_user_home_in_sidebar
- sprout-terminal::default
- sprout-osx-apps::ssh_copy_id
- sprout-osx-apps::caffeine
EOF

# Download the repo, or just update if it exists
if [[ -d soloist-mach-deploy ]]; then
  cd soloist-mach-deploy && git pull && cd ..
else
  https://github.com/dgrider/soloist-mach-deploy.git
fi

# Run Chef soloist
soloist
popd
