#!/usr/bin/python3
# Reads cursor location and creates hot corners
# Based on https://github.com/ens1/cornered/blob/master/cornered.py

# Works only on the X11 root display

import time
import configparser
import os
from Xlib import display, X
from subprocess import Popen

d = display.Display()
width_in_pixels = d.screen().width_in_pixels
height_in_pixels = d.screen().height_in_pixels

cornerSize = 3 # Pixels

config = configparser.ConfigParser()
config.read(os.path.expanduser("~/.config/corneredconf"))

top_left_command = ""
bottom_left_command = ""
top_right_command = ""
bottom_right_command = ""

try:
    top_left_command = config.get("config", "top_left")
    bottom_left_command = config.get("config", "bottom_left")
    top_right_command = config.get("config", "top_right")
    bottom_right_command = config.get("config", "bottom_right")

    top_left_timeout = config.getfloat("config", "top_left_timeout", fallback=0.5)
    bottom_left_timeout = config.getfloat("config", "bottom_left_timeout", fallback=0.5)
    top_right_timeout = config.getfloat("config", "top_right_timeout", fallback=0.5)
    bottom_right_timeout = config.getfloat("config", "bottom_right_timeout", fallback=0.5)

except configparser.NoSectionError:
    print("Config file incorrect or missing from ~/.config/corneredconf")
    exit()
except configparser.NoOptionError:
    pass

def exec_command(command):
    try:
        Popen(command)
    except OSError:
        pass

while True:
    x_coord = d.screen().root.query_pointer().win_x
    y_coord = d.screen().root.query_pointer().win_y

    if x_coord < cornerSize:
        if y_coord < cornerSize:
            exec_command(top_left_command.split(' '))
            time.sleep(top_left_timeout)

        if y_coord > height_in_pixels - cornerSize:
            exec_command(bottom_left_command.split(' '))
            time.sleep(bottom_left_timeout)

    if x_coord > width_in_pixels - cornerSize:
        if y_coord < cornerSize:
            exec_command(top_right_command.split(' '))
            time.sleep(top_right_timeout)

        if y_coord > height_in_pixels - cornerSize:
            exec_command(bottom_right_command.split(' '))
            time.sleep(bottom_right_timeout)

    time.sleep(1) # Checks every second for activity

