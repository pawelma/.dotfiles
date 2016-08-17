#backend = "xr_glx_hybrid";
vsync = "opengl-swc";

xrender-sync = true;
xrenderer-sync-fence = true;

unredir-if-possible = true;
unredir-if-possible-exclude = [
    #"class_g ?= 'mpv'",
    #"class_g ?= 'Firefox'",
    #"class_g ?= 'google-chrome'"
];

use-ewmh-active-win = true;

opacity-rule = [
  "80:class_g = 'URxvt' && !_NET_WM_STATE@:32a",
  #"80:class_g = 'i3bar' && !_NET_WM_STATE@:32a",
  "75:class_g = 'i3-frame' && !_NET_WM_STATE@:32a"
];

paint-on-overlay = true;
shadow = true;
shadow-radius = 12;
shadow-offset-y = -14;
shadow-offset-x = -16;
shadow-opacity = 1;
clear-shadow = true;
no-dnd-shadow = true;
shadow-ignore-shaped = true;
shadow-exclude = [
    "! name~=''",
    #"class_g = 'i3bar'",
    "class_g = 'Plank'",
    "class_g = 'Firefox' && argb",
    "x <= 3 && x2 >= 1920 && y <= 30 && y2 >= 1080"
];

fading = false;
fade-in-step = 0.1;
fade-out-step = 0.1;

