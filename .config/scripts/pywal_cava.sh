#!/bin/bash

if [ -f $HOME/.cache/wal/cava ]; then
  cp $HOME/.cache/wal/cava $HOME/.config/cava/config
  # Sending cava a SIGUSR1 signal, will force cava to reload its configuration file. Thus, it behaves as if the user pressed r in the terminal. One might send a SIGUSR1 signal using pkill or killall.
  # Docs: https://github.com/karlstav/cava/blob/master/README.md#configuration
  pkill -USR1 cava
fi
