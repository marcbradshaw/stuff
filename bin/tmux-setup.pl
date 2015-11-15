#!/usr/bin/perl

use strict;
use warnings;

my @config;

push @config, 'set -g default-terminal "screen-256color"';
push @config, 'set -g history-limit 10000';
push @config, 'set -g mouse';
push @config, 'set-option -g terminal-overrides \'xterm*:smcup@:rmcup@\'';

push @config, 'set -g status-utf8 on';
push @config, 'set -g status-justify left';
push @config, 'set -g status-bg default';
push @config, 'set -g status-fg colour12';
push @config, 'set -g status-interval 2';

push @config, 'set -g message-fg black';
push @config, 'set -g message-bg yellow';
push @config, 'set -g message-command-fg blue';
push @config, 'set -g message-command-bg black';

push @config, 'setw -g mode-bg colour6';
push @config, 'setw -g mode-fg colour0';

push @config, 'setw -g window-status-current-attr none';
push @config, 'setw -g window-status-attr none';

#  

push @config, 'setw -g window-status-current-format "#[bg=colour152]#[fg=colour160]#I#[fg=colour160]#F#[bg=colour140]#[fg=colour152]#[fg=blue]#W#[fg=colour140]#[bg=black]"';
push @config, 'setw -g window-status-format         "#[bg=colour242]#[fg=colour254]#I#[fg=colour252]#F#[bg=colour238]#[fg=colour242]#[fg=cyan]#W#[fg=colour238]#[bg=black]"';

my @status_parts;

my @status_colours = ( 'blue:colour11', 'colour11:green', 'cyan:blue', 'colour13:red', ); 

# Free Memory
if ( -e '/usr/bin/free' ) { 
    push @status_parts, ' ♈ #(free -h |grep "^Mem:"|tr -s " "|cut -d " " -f 4)  #(free -h |grep "^Swap:"|tr -s " "|cut -d " " -f 4) ';
}

# Load Average
if ( -e '/proc/loadavg' ) {
    #push @status_parts, ' ⚒ #(cut -d " " -f 1-3 /proc/loadavg) ';
    push @status_parts, ' ⚒ #(cut -d " " -f 1 /proc/loadavg) ';
}

# WIFI Bit Rate
my $interface = 'wlan0';
if ( -e '/sbin/iwlist' ) {
    push @status_parts, ' ⇄ #(iwlist ' . $interface . ' rate|grep "Current Bit Rate:"|cut -d ":" -f 2) ';
}

# Battery
if ( -e '/usr/bin/upower' ) {
    push @status_parts, ' ⚡ #(upower -i $(upower -e | grep \'BAT\')|grep "percentage:"|tr -s " " | cut -d " " -f 3) ';
}

# Time
push @status_parts, ' %a %d %b ⌚ %H:%M ';

my $status_right = q{};
my $last_bg='black';

my $i = 0;
foreach my $part ( @status_parts ) {
  my $colours = $status_colours[$i++];
  $i = 0 if $i == scalar @status_colours;
  my ( $bg, $fg ) = split ':', $colours;
  $status_right .= "#[fg=$bg]#[bg=$last_bg]#[fg=$fg]#[bg=$bg]$part";
  $last_bg = $bg;
}

push @config, 'set -g status-right \'' . $status_right . '\'';
push @config, 'set -g status-right-length 100';

push @config, 'set -g status-left \'#[bg=blue]#[fg=cyan] #S #[bg=black]#[fg=blue] \'';
push @config, 'set -g status-left-length 40';

#push @config, 'bind-key j command-prompt -p "join pane from:"  "join-pane -s \'%%\'"';
push @config, 'bind-key S command-prompt -p "send pane to:"  "join-pane -t \'%%\'"';

my $filename = $ENV{'HOME'} . '/.tmux.conf';
open my $outf, '>', $filename;
print $outf join( "\n", @config );
close $outf;

system 'tmux source ' . $filename;

