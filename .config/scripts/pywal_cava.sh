#!/bin/bash

if [ -f $HOME/.cache/wal/cava ]; then
  cp $HOME/.cache/wal/cava $HOME/.config/cava/config
fi
