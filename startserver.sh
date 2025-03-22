#!/bin/bash

# Kill existing VNC sessions
vncserver -kill :1 2>/dev/null
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# Start VNC server
vncserver :1 -geometry 1280x720 -depth 24

# Start NoVNC
websockify --web=/workspaces/VNC-Server/ 6080 localhost:5901
