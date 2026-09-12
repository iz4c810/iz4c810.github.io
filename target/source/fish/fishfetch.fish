#!/usr/bin/env fish
#
# fishfetch — a small fastfetch-style system info printer, written in fish.
# Usage: chmod +x fishfetch.fish && ./fishfetch.fish

# ---- gruvbox-ish colors -----------------------------------------------
set c_label  (set_color d3869b)   # purple
set c_value  (set_color ebdbb2)   # fg
set c_art    (set_color 8ec07c)   # aqua
set c_accent (set_color fabd2f)   # yellow
set c_rule   (set_color 665c54)   # gray
set c_reset  (set_color normal)

# ---- gather info --------------------------------------------------------
set user (whoami)
set host (hostname)

set os "unknown"
if test -f /etc/os-release
    set os (grep -oP '(?<=^PRETTY_NAME=").*(?=")' /etc/os-release 2>/dev/null)
    if test -z "$os"
        set os (uname -s)
    end
else
    set os (uname -s)
end

set kernel (uname -r)

set uptime_str "unknown"
if type -q uptime
    set uptime_str (uptime -p 2>/dev/null | string replace -r '^up ' '')
end

set shell_str "fish "(fish --version | string match -r '[0-9.]+')

set pkgs "n/a"
if type -q dpkg
    set pkgs (dpkg -l 2>/dev/null | grep -c '^ii')" (dpkg)"
else if type -q pacman
    set pkgs (pacman -Qq 2>/dev/null | count)" (pacman)"
end

set cpu "unknown"
if test -f /proc/cpuinfo
    set cpu (grep -m1 'model name' /proc/cpuinfo | string replace -r '^model name\s*:\s*' '')
end

set mem "unknown"
if type -q free
    set mem_used (free -h | awk '/^Mem:/ {print $3}')
    set mem_total (free -h | awk '/^Mem:/ {print $2}')
    if test -n "$mem_used"
        set mem "$mem_used / $mem_total"
    end
end

set term_str "$TERM"
if test -z "$term_str"
    set term_str "n/a"
end

set now (date "+%H:%M")

# ---- ascii art (small fish, obviously) ----------------------------------
set art_lines \
    '   ,      ' \
    '  ><(((o>  ' \
    '   ~~~~    ' \
    '           ' \
    ' swimming  ' \
    ' since boot' \
    ' and hiding' \
    ' things    '

# ---- info rows -----------------------------------------------------------
set info_labels User Host OS Kernel Uptime Shell Packages CPU Memory Terminal Time
set info_values "$user" "$host" "$os" "$kernel" "$uptime_str" "$shell_str" "$pkgs" "$cpu" "$mem" "$term_str" "$now"

# ---- render side by side ---------------------------------------------------
set n_art (count $art_lines)
set n_info (count $info_labels)
set n_rows $n_art
set n_info_plus (math "$n_info + 2")
if test $n_info_plus -gt $n_rows
    set n_rows $n_info_plus
end

for i in (seq 1 $n_rows)
    set art_col ""
    if test $i -le $n_art
        set art_col $art_lines[$i]
    end
    printf "%s%-14s%s  " $c_art "$art_col" $c_reset

    if test $i -eq 1
        printf "%s%s@%s%s\n" $c_accent "$user" "$host" $c_reset
    else if test $i -eq 2
        printf "%s%s%s\n" $c_rule (string repeat -n 22 -- '-') $c_reset
    else
        set idx (math $i - 2)
        if test $idx -ge 1 -a $idx -le $n_info
            printf "%s%-10s%s %s%s%s\n" $c_label "$info_labels[$idx]" $c_reset $c_value "$info_values[$idx]" $c_reset
        else
            printf "\n"
        end
    end
end

echo
printf "%s" $c_reset
for hexname in fb4934 fabd2f b8bb26 83a598 d3869b 8ec07c fe8019 ebdbb2
    printf "%s██%s" (set_color $hexname) $c_reset
end
echo
