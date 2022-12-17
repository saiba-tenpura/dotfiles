# NNN

# Adds 'n' function with automatic cd on quit
if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    . /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

export NNN_BMS='d:~/Documents;D:~/Downloads'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_OPTS='dH'
export NNN_PLUG='p:preview-tui;v:imgview'

