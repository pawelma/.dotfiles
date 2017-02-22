var plasma = getApiVersion(1);

var layout = {
    "desktops": [
        {
            "applets": [
                {
                    "config": {
                    },
                    "geometry.height": 10,
                    "geometry.width": 16,
                    "geometry.x": 0,
                    "geometry.y": 59,
                    "plugin": "org.kde.plasma.systemmonitor.cpu",
                    "title": "CPU Load Monitor"
                },
                {
                    "config": {
                        "/Appearance": {
                            "enabledCalendarPlugins": "/usr/lib/qt/plugins/plasmacalendarplugins/holidaysevents.so",
                            "showWeekNumbers": "true"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "geometry.height": 6,
                    "geometry.width": 10,
                    "geometry.x": 127,
                    "geometry.y": 9,
                    "plugin": "org.kde.plasma.digitalclock",
                    "title": "Digital Clock"
                },
                {
                    "config": {
                        "/Appearance": {
                            "fuzzyness": "4"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "geometry.height": 7,
                    "geometry.width": 32,
                    "geometry.x": 0,
                    "geometry.y": 17,
                    "plugin": "org.kde.plasma.fuzzyclock",
                    "title": "Fuzzy Clock"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/General": {
                    "ToolBoxButtonState": "bottomleft",
                    "ToolBoxButtonY": "1414"
                },
                "/Wallpaper/General": {
                    "Color": "invalid",
                    "FillMode": "2",
                    "SlideInterval": "1",
                    "SlidePaths": "\\0"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Color": "invalid",
                    "FillMode": "2",
                    "Image": "file:///home/pawel/Pictures/Wallpapers/Firefox_wallpaper.png",
                    "SlideInterval": "1",
                    "SlidePaths": "\\0",
                    "height": "1440",
                    "width": "2560"
                },
                "/Wallpaper/org.kde.plasma.wallpaper.worldmap/General": {
                    "projection": "Mercator"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "left",
            "applets": [
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "favorites": "preferred://browser,systemsettings.desktop,org.kde.dolphin.desktop,Dota 2.desktop,spotify.desktop",
                            "icon": "manjaro"
                        },
                        "/Shortcuts": {
                            "global": "Alt+F1"
                        }
                    },
                    "plugin": "org.kde.plasma.kickoff"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "currentDesktopSelected": "ShowDesktop",
                            "displayedText": "Number"
                        }
                    },
                    "plugin": "org.kde.plasma.pager"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        }
                    },
                    "plugin": "org.kde.plasma.calculator"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "plugin": "org.kde.milou"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/General": {
                            "expanding": "false",
                            "length": "1083"
                        }
                    },
                    "plugin": "org.kde.plasma.panelspacer"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "pressureUnit": "5008",
                            "source": "bbcukmet|weather|Warsaw Chopin Airport, Poland|http://open.live.bbc.co.uk/weather/feeds/en/6296786/observations.rss",
                            "speedUnit": "9001",
                            "temperatureUnit": "6001",
                            "updateInterval": "30",
                            "visibilityUnit": "2007"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "plugin": "org.kde.plasma.weather"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/Calendar": {
                            "month_show_weeknumbers": "true"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "clock_24h": "true",
                            "clock_fontfamily": "Sans Serif",
                            "clock_maxheight": "27",
                            "clock_timeformat": "'<font color=\"#3daee9\">'MMM d'</font>' HH:mm",
                            "clock_timeformat_2": "MMM d",
                            "widget_show_timer": "false"
                        },
                        "/Configuration/Google%20Calendar": {
                            "events_pollinterval": "60"
                        },
                        "/Configuration/Weather": {
                            "weather_city_id": "756135"
                        }
                    },
                    "plugin": "org.kde.plasma.eventcalendar"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/General": {
                            "length": "104"
                        }
                    },
                    "plugin": "org.kde.plasma.panelspacer"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        }
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "monitorType": "Circular",
                            "swapActivated": "false"
                        }
                    },
                    "plugin": "org.kde.plasma.systemloadviewer"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        },
                        "/Configuration/General": {
                            "show_lockScreen": "false"
                        }
                    },
                    "plugin": "org.kde.plasma.lock_logout"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "84",
                    "DialogWidth": "2560"
                }
            },
            "height": 1.4444444444444444,
            "hiding": "normal",
            "location": "top",
            "maximumLength": 142.22222222222223,
            "minimumLength": 142.22222222222223,
            "offset": 0
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
