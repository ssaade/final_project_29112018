#!/bin/sh


fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Installing ability to open files from terminal"
npm install -g c9
fancy_echo "Installing rufo gem"
gem install rufo -v 0.3.1
fancy_echo "Installing htmlbeautifier gem"
gem install htmlbeautifier
fancy_echo "Installing plugins"
mkdir ~/.c9/plugins
git clone https://github.com/firstdraft/rubysnippets.git ~/.c9/plugins/rubysnippets
git clone https://github.com/firstdraft/formathtmlerb.git ~/.c9/plugins/formathtmlerb
git clone https://github.com/firstdraft/formatruby.git ~/.c9/plugins/formatruby
