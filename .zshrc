# The default interfered with deleting words. This enables the familiar
# bash-like behaviour.
# See https://stackoverflow.com/a/1438523
autoload -U select-word-style
select-word-style bash

# Gives /usr/bin the priority over /usr/loca/bin
# Required because plugins (YCM, specifically) from my vim installation
# from /usr/loca/bin runs into trouble finding Python dependencies
export PATH=/usr/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/Applications/Wireshark.app/Contents/MacOS:/Users/apnargundkar/.cargo/bin

# Had to add this to bind <C-s> in vim
# See https://stackoverflow.com/a/11298171
stty -ixon


