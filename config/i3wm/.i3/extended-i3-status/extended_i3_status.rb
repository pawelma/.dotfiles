#!/usr/bin/env ruby

require 'r3status'

include R3Status
include R3Status::Blocks


status_line = StatusLine.new(prefix: '\t')

system = BlockGroup.new
system << Memory.new(format: '  %{val}%', colors: {high: '#ff3333'})
status_line << system

indicators = BlockGroup.new

indicators << Power.new(
    formats: {charging: "   %{capacity}%", default: "  %{capacity}\%"},
    colors: {full: '#69B842', charging: '#F4C91D', discharging: '#9B3E9B'}
    )

indicators << KeyboardLayout.new(
    formats: {il: "  HE", us: "  EN"},
    colors: {il: '#5E88EF', us: '#B82E27'}
    )

indicators << Volume.new
status_line << indicators
time = BlockGroup.new(blocks: [
  Clock.new(format: " %H:%M"),
  Clock.new(format: " %e/%m/%Y"),
])

status_line << time

status_line.run