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

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, ScratchPad, Screen, Match
from libqtile.lazy import lazy

# from libqtile.utils import guess_terminal
from libqtile import hook
import os
import subprocess


colors = dict(
    # Tokyonight colors
    background="#1a1b26",
    foreground="#c0caf5",
    black="#15161E",
    red="#f7768e",
    green="#9ece6a",
    yellow="#e0af68",
    blue="#7aa2f7",
    magenta="#bb9af7",
    cyan="#7dcfff",
    white="#a9b1d6",
)


@hook.subscribe.screen_change  # change the number of bars when screens change
def screen_change():
    screen_number = len(os.popen(r"xrandr | grep '\sconnected\s'").readlines())
    # Changes widget based on laptop vs desktop
    if os.uname()[1].lower().find("laptop") == -1:  # desktop config
        bar_height = 20
        primary_widgets = [
            widget.Image(
                filename="/usr/share/pixmaps/archlinux-logo.png",
                mouse_callbacks={
                    "Button1": lambda qtile: qtile.cmd_spawn(
                        "alacritty -e sudo pacman -Syu"
                    )
                },
            ),
            widget.CurrentLayout(),
            widget.GroupBox(
                highlight_method="block",
                this_current_screen_border=colors["blue"],
                urgent_alert_method="block",
                urgent_border=colors["red"],
                disable_drag=True,
            ),
            widget.WindowName(),
            widget.Sep(),
            widget.TextBox(text="Volume"),
            widget.PulseVolume(step=1),
            widget.Sep(),
            widget.Systray(),
            # widget.StatusNotifier(),
            widget.Sep(),
            widget.Clock(format="%m-%d %a %I:%M %p"),
            widget.Sep(),
            widget.QuickExit(
                default_text="",
                countdown_format="[ {} ]",
                countdown_start=3,
                padding=8,
            ),
        ]
        secondary_widgets = [
            widget.Image(
                filename="/usr/share/pixmaps/archlinux-logo.png",
                mouse_callbacks={
                    "Button1": lambda qtile: qtile.cmd_spawn(
                        "alacritty -e sudo pacman -Syu"
                    )
                },
            ),
            widget.CurrentLayout(),
            widget.GroupBox(
                highlight_method="block",
                this_current_screen_border=colors["blue"],
                urgent_alert_method="block",
                urgent_border=colors["red"],
                disable_drag=True,
            ),
            widget.WindowName(),
            widget.Sep(),
            widget.TextBox(text="Volume"),
            widget.PulseVolume(),
            widget.Sep(),
            widget.Clock(format="%m-%d %a %I:%M %p"),
            widget.Sep(),
            widget.QuickExit(
                default_text="",
                countdown_format="[ {} ]",
                countdown_start=3,
                padding=5,
            ),
        ]
    else:  # laptop config
        bar_height = 24
        primary_widgets = [
            widget.Image(
                filename="/usr/share/pixmaps/archlinux-logo.png",
                mouse_callbacks={
                    "Button1": lambda qtile: qtile.cmd_spawn(
                        "alacritty -e sudo pacman -Syu"
                    )
                },
            ),
            widget.CurrentLayout(),
            widget.GroupBox(
                highlight_method="block",
                this_current_screen_border=colors["blue"],
                urgent_alert_method="block",
                urgent_border=colors["red"],
                disable_drag=True,
            ),
            widget.WindowName(),
            widget.Sep(),
            widget.TextBox(text="Volume"),
            widget.PulseVolume(),
            widget.Sep(),
            widget.TextBox(text="Brightness"),
            widget.Backlight(backlight_name="intel_backlight"),
            widget.Sep(),
            widget.Battery(format="{char} {percent:2.0%} {hour:d}:{min:02d}"),
            widget.BatteryIcon(),
            widget.Sep(),
            widget.Wlan(interface="wlp2s0", format="{essid} {percent:2.0%}"),
            widget.Systray(),
            # widget.StatusNotifier(),
            widget.Sep(),
            widget.Clock(format="%m-%d %a %I:%M %p"),
            widget.Sep(),
            widget.QuickExit(
                default_text="Logout", countdown_format="[ {} ]", countdown_start=3
            ),
        ]
        secondary_widgets = [
            widget.Image(
                filename="/usr/share/pixmaps/archlinux-logo.png",
                mouse_callbacks={
                    "Button1": lambda qtile: qtile.cmd_spawn(
                        "alacritty -e sudo pacman -Syu"
                    )
                },
            ),
            widget.CurrentLayout(),
            widget.GroupBox(
                highlight_method="block",
                this_current_screen_border=colors["blue"],
                urgent_alert_method="block",
                urgent_border=colors["red"],
                disable_drag=True,
            ),
            widget.WindowName(),
            widget.Sep(),
            widget.TextBox(text="Volume"),
            widget.PulseVolume(),
            widget.Sep(),
            widget.TextBox(text="Brightness"),
            widget.Backlight(backlight_name="intel_backlight"),
            widget.Sep(),
            widget.Battery(format="{char} {percent:2.0%} {hour:d}:{min:02d}"),
            widget.BatteryIcon(),
            widget.Sep(),
            widget.Wlan(interface="wlp2s0", format="{essid} {percent:2.0%}"),
            widget.Sep(),
            widget.Clock(format="%m-%d %a %I:%M %p"),
            widget.Sep(),
            widget.QuickExit(
                default_text="", countdown_format="[ {} ]", countdown_start=3
            ),
        ]

    screens = []
    for i in range(screen_number):
        if i == 0:  # Systray on primary screen
            screens.append(
                Screen(
                    top=bar.Bar(
                        primary_widgets, bar_height, background=colors["background"]
                    )
                )
            )
        else:
            screens.append(
                Screen(
                    top=bar.Bar(
                        secondary_widgets, bar_height, background=colors["background"]
                    )
                )
            )
    return screens


screens = screen_change()

mod = "mod4"
terminal = "alacritty"
home = os.path.expanduser("~")

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.up(), desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus up in stack pane"),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "g", lazy.layout.grow()),
    Key([mod], "s", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    # Move windows up or down in current stack
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window down in current stack ",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window up in current stack ",
    ),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    # Switch window focus to other pane(s) of stack
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui")),
    # Swap panes of split stack
    Key(
        [mod, "shift"], "space", lazy.layout.rotate(), desc="Swap panes of split stack"
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Last layout"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    # Key([mod], "r", lazy.spawncmd(),
    #     desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key(
        [mod],
        "i",
        lazy.spawn(home + "/repos/rofi/1080p/launchers/colorful/launcher.sh"),
    ),
    Key([mod, "control"], "l", lazy.spawn(home + "/repos/scripts/i3lock.sh")),
    # Backlight keys
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5")),
    # Media keys
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --player=spotify previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=spotify next")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --player=spotify play-pause")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ),
    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "c", lazy.group["scratchpad"].dropdown_toggle("nvim org")),
    Key([mod], "m", lazy.group["scratchpad"].dropdown_toggle("music")),
    Key([mod], "f", lazy.group["scratchpad"].dropdown_toggle("browser")),
    # Switch monitor focus
    Key([mod], "o", lazy.to_screen(1)),
    Key([mod], "a", lazy.to_screen(0)),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + ctrl + letter of group = switch to & move focused window to group
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown("term", "alacritty", opacity=0.8, height=0.5),
            DropDown(
                "nvim org",
                "alacritty -e /home/spencer/repos/scripts/org.sh",
                width=0.5,
                height=0.5,
                opacity=0.8,
                x=0.24,
            ),
            DropDown(
                "music", "spotify-launcher", opacity=0.8, width=0.5, height=1.0, x=0.24
            ),
        ],
    )
)

layouts = [
    layout.MonadTall(border_focus=colors["cyan"]),
    layout.Max(border_focus=colors["cyan"]),
    layout.Stack(num_stacks=2, border_focus=colors["cyan"]),
    layout.Matrix(border_focus=colors["cyan"]),
    layout.Bsp(border_focus=colors["cyan"]),
]

widget_defaults = dict(
    font="Fantasque Sans Mono Nerd Font",
    # font='Ubuntu Mono Nerd Font',
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button2", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button3", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="Firefox"),
        Match(wm_class="gnome-screenshot"),
        Match(wm_class="zoom"),
        Match(wm_class="barrier"),
        Match(wm_class="Export"),
        Match(wm_class="feh"),
        Match(wm_class="Pinentry-gtk-2"),
        Match(wm_class="spectacle"),
    ]
)
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


@hook.subscribe.startup_once
def autostart():
    autostart = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([autostart])
