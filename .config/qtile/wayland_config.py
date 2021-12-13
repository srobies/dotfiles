# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, Screen, ScratchPad
from libqtile.lazy import lazy

mod = "mod4"
terminal = 'alacritty'
colors = dict(
    background= '#1a1b26',
    foreground= '#c0caf5',
    black=   '#15161E',
    red=     '#f7768e',
    green=   '#9ece6a',
    yellow=  '#e0af68',
    blue=    '#7aa2f7',
    magenta= '#bb9af7',
    cyan=    '#7dcfff',
    white=   '#a9b1d6',
    )

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    # Key([mod, "control"], "h", lazy.layout.grow_left(),
    #     desc="Grow window to the left"),
    # Key([mod, "control"], "l", lazy.layout.grow_right(),
    #     desc="Grow window to the right"),
    # Key([mod, "control"], "j", lazy.layout.grow_down(),
    #     desc="Grow window down"),
    # Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "k", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "i", lazy.spawn("wofi --show drun -I"), desc="Launch wofi"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    
    Key([mod], 't', lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], 'c', lazy.group['scratchpad'].dropdown_toggle('nvim org')),
    Key([mod], 'm', lazy.group['scratchpad'].dropdown_toggle('music')),
    Key([mod], 'f', lazy.group['scratchpad'].dropdown_toggle('browser')),
    
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --player=spotify previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=spotify next")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --player=spotify play-pause")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        Key([mod, "control"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])

groups.append(ScratchPad("scratchpad", [
    DropDown("term", "alacritty", opacity=0.9, height=0.5),
    DropDown("nvim org", "alacritty -e /home/spencer/repos/scripts/org.sh",
             width=0.5, height=0.5, x=0.24),
    DropDown("music", "cage spotify", opacity=0.8,width=0.5, height=1.0, x=0.24),
    DropDown("browser", "firefox --new-instance", opacity=0.8, width=0.8, height=0.9),
    ]))

layouts = [
    layout.MonadTall(border_focus=colors['cyan']),
    layout.Max(),
    layout.Stack(num_stacks=2,border_focus=colors['cyan']),
    layout.Bsp(border_focus=colors['cyan']),
    layout.Matrix(border_focus=colors['cyan']),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(highlight_method='block',
                                this_current_screen_border=colors['blue'],
                                urgent_alert_method='block',
                                urgent_border=colors['red'],
                                disable_drag=True),
                widget.WindowName(),
                widget.Wlan(),
                widget.Sep(),
                widget.TextBox(text='Volume'),
                widget.PulseVolume(),
                widget.Sep(),
                widget.Backlight(backlight_name='intel_backlight'),
                widget.Sep(),
                widget.Battery(format='{percent:2.0%}'),
                widget.BatteryIcon(),
                widget.KeyboardLayout(configured_keyboards=['dvorak', 'us'], display_map={'us':'us', 'dvorak':'dv'}),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='spectacle'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
