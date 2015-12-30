# Options, exports and stuff {{{

export TERM=xterm-256color
autoload -U colors && colors

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.histzsh
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt histignorealldups sharehistory

setopt prompt_subst
setopt glob_dots
setopt EXTENDED_GLOB
setopt extendedglob
unsetopt no_match

unsetopt beep

setopt long_list_jobs
if [ $USER = 'yaon' ]; then; UUUU='i'; else; UUUU=$USER; fi
export PROMPT="$UUUU %(?,%{$fg[green]%}%%%{$reset_color%},%{$fg[red]%}#%{$reset_color%}) "
export RPROMPT=''
export PAGER='less'
export LESS="-R"
export PATH="/sbin:$PATH:/home/yaon/syndex/syndex-7.0.6"
export EDITOR='/usr/bin/vim'
export WORDCHARS=''
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
export LSCOLORS="Gxfxcxdxbxegedabagacad" export LC_CTYPE=en_US.UTF-8
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export MAKEFLAGS='--no-print-directory'

# because why the fuck not here
setxkbmap us -variant altgr-intl

# }}}
# {{{ completion

autoload -Uz compinit
compinit
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end
unsetopt complete_aliases

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/chewie/.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
eval "$(dircolors -b)"
zstyle ':completion:*' use-compctl false
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# }}}
# {{{ Keys

# Edit command line with <c-w>
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey '\C-,' edit-command-line

# Move word by word
bindkey ';5D' backward-word
bindkey ';5C' forward-word

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# }}}
# {{{ Aliases

alias 5get='echo pyshell: code.interact(local=locals())'

## univ
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias valgrind='valgrind -v --leak-check=full --show-reachable=yes\
 --track-fds=yes --track-origins=yes --malloc-fill=42 --free-fill=43'
alias ll='ls -l'
alias la='ls -la'
alias j='jobs'
alias rm='rm -i' # dem safety
alias cb='cd .. && ls'
alias mvd='mv ~/Downloads/* ./'
mvw() {sudo mv $1 /media/sf_Jim/share}
getw() {sudo cp -r /media/sf_Jim/$1 .}
alias lsn='ls -lt  **/*(.om[1,20])' # list 20 newest files
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --" # copy with progress bar
alias lsh='ls *(.)' # ls hidden files
alias lsf='ls *~*.*(.)' # ls files
alias lsd='ls -d */' # ls folder
alias -g ND='*(/om[1])' # newest directory
alias -g NF='*(.om[1])' # newest file FIXME: allways .histfile ...
alias lsL='ls -hlS **/*(.Lm+2)  | less' # list largest files  largest first  *N*
alias -g G="| grep" #fuck this
alias -g L="| less" #and that (i still like you two)
gr() {grep -rnI $1 --exclude=tags .}

alias gls='git log --stat'
alias glr='git log --raw'
alias glg='git log --graph'
alias gll='git log --pretty=oneline'
alias glp='git log -p'

alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

# essencial
alias repof='sudo reboot'
alias pof='sudo poweroff'
alias pozzerio='sudo poweroff'
function cl { cd $1 && ls } #kinda disgusting
function mkcd() { mkdir -p $1; cd $1 }
function light { xbacklight -set $1 }
function sagi { sudo apt-get -y install $1 } #1
alias kj='killall java'
alias goo='chromium-browser &'
alias kgs='javaws http://files.gokgs.com/javaBin/cgoban.jnlp'
alias zr='vim ~/tools/zshrc'
alias gr='vim ~/tools/gitconfig'
alias vr='vim ~/tools/vimrc'
alias MINE="sudo chown -R $USER.$USER" #1 too
alias pig='ping google.com'
manopt(){ man $1 |sed 's/.\x08//g'|sed -n "/^\s\+-\+$2\b/,/^\s*$/p"|sed '$d;';}
alias reconfig='kill -s USR2 `xprop -root _BLACKBOX_PID | awk '"'"'{print $3}'"'"'`'
cpspd() {rsync --bwlimit=200 src dest} # Do an rsync and limit the bandwidth used to about 200KB/sec.
#vvar() {OIFS=$IFS;IFS=$'\n';vim $( grep -l '$fill' *.pl );IFS=$OIFS} # Edit the set of files that contain the variable $somevar.

#dompter le tigre
alias bcm='./bootstrap && ./configure && make -j4'
alias cm='./configure && make -j4'
alias mk='make -j4 &'
alias st='git status | head -n 25'
alias mh='make -j4 2> /tmp/mh; cat /tmp/mh | head -n 25'

## advanced syntax correction
alias mec='make'
alias gf='fg'
alias sv='sudo vim'
alias v='vim'
alias jim='vim'
alias bim='vim'
alias vin='vim'
alias nano='vim'
alias pico='vim'
alias emacs='vim'
alias gedit='vim'
alias notepad='vim'
alias world='vim'
alias notepad++='vim'
alias g='git'
alias rtfm='man'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias sou='source ~/.zshrc'
alias age='echo $(( $(( $( date +%s ) - $( date -d "1991-09-23" +%s ) )) / 86400 / 365))'
# alias please='sudo '
alias please='sudo `cat $HISTFILE | tail -n2 | head -n1 | cut -d ";" -f 2`'

# {{{ pig
rainbow(){ for i in {1..7}; do tput setaf $i; echo $@; tput sgr0; done; }
lucky(){ awk -varg=^$1 '$0~arg' .histzsh | shuf | head -1; }
factorial(){ seq -s* $1 -1 ${2:-1} | bc; }
dolphin () { for t in {1..7} ;do for i in _ . - '*' - . _ _ _ ;do echo -ne "\b\b__${i}_";sleep 0.20;done;done; }
randomcd(){ d=$(find / -maxdepth 1 -type d \( -path '/root' -prune -o -print \) | shuf | head -1); cd "$d"; } # randomcd is random.
am_i_right(){ echo yes; true; }
amarite(){ echo yes; true; }
ttest1() {while :;do t=($(date +"%l %M %P")); [[ "${t[1]}" == 0 ]] && echo "${t[0]} ${t[2]}" |(espeak||say); sleep 1m; done} # Speak the hour
# }}}

# stage
alias -g SC="~/script/"
alias -g PR="~/php/"
alias cdp='cd /home/yaon/vide'
alias cds='cd /home/vide/script'
alias cdd='cd ~/Downloads'
alias debugApache='sudo tail -f /var/log/apache2/error.log'
alias dbApache='sudo scp 192.168.1.2:/var/log/apache2 /tmp/; less /tmp/apache2'
alias uploadToServ='cd ~/vide; scp -r ^.* vide@192.168.1.2:/var/www/'
alias -g P1='vide@192.168.1.2'
alias -g P2='vide@192.168.1.3'
alias -g P3='vide@192.168.1.4'
alias -g MP='vide@192.168.1.23'
alias -g MS='vide@192.168.1.100'

# mine
alias cda='cd /home/yaon/aureole'
alias suj='evince ~/dev/suj.pdf &'
alias sli='evince ~/dev/sli.pdf &'
alias -g LOCPI='pi@192.168.0.46'
alias pissh='ssh -p 22233 pi@93.19.13.24'
alias euler='vim ~/proj/euler/euler.py'

# python
alias py='python3.2'
alias tree='tree -I node_modules -I bower_components'

#
alias shit='ls -shit'
alias tmux="TERM=screen-256color-bce tmux"
function ifd { sudo ifdown $1 && sudo ifup $1 }
alias interfaces='sudo vim /etc/network/interfaces'
alias sl='ls'
add_alias() { echo "alias $1='$2'" >> ~/.zshrc }
alias gogui='~/sft/gogui-1.4.9/bin/gogui'

alias WILL_LE_RELOU='git fetch origin && g checkout -B origin origin/master'
slack(){curl --data $1 $'https://epita.slack.com/services/hooks/\
    slackbot?token=7SgojHHw327YWHrUOohG9gCA&channel=%23'$2}
# }}}
# {{{ no scripts aloud
# {{{ ttv
function ttv
{
    sshpass -p ediv scp -r /var/www/py/toggleTv.py vide@192.168.1.2:/var/www/py/
    sshpass -p ediv ssh vide@192.168.1.2 "/var/www/py/toggleTv.py $1 $2"
}
# }}}
# {{{ piwall
function piwall
{
    if [ $# -eq 0 ]; then
        pwomxplayer udp://239.0.1.23:1234?buffer_size=1200000B
    else
        pwomxplayer --tile-code=$1 udp://239.0.1.23:1234?buffer_size=1200000B
    fi
}
# }}}
# {{{ piwall_master video
function piwall_master
{
    while true; do
        avconv -re -i $1 -vcodec copy -an -f avi udp://239.0.1.23:1234
    done
}
# }}}
# {{{ piEncode in out
function piEncode
{
    #mencoder $1 -o $2 -oac copy -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg
    mencoder -oac pcm -ovc copy -aid 1 $1 -o $1.mp4
}
# }}}
# {{{ mkc
function mkc
{
    touch $1.c
    touch $1.h

    chmod 640 $1.c
    chmod 640 $1.h

    CAPS=`echo $1 | tr [a-z] [A-Z]`

    echo "#ifndef $CAPS"_H_ >> $1.h
    echo "# define $CAPS"_H_ >> $1.h
    echo >> $1.h
    echo >> $1.h
    echo >> $1.h
    echo "#endif /* !$CAPS""_H_ */" >> $1.h
    echo "#include \"$1.h\"" >> $1.c
} # }}}
#{{{ mkcc
function mkcc
{
    touch $1.cc
    touch $1.hh

    chmod 640 $1.cc
    chmod 640 $1.hh

    CAPS=`echo $1 | tr [a-z-] [A-Z_]`
    #Class=`echo ${1:0:1} | tr [a-z] [A-Z]`
    echo "#ifndef $CAPS"_HH_ >> $1.hh
    echo "# define $CAPS"_HH_ >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo "#endif /* !$CAPS""_HH_ */" >> $1.hh

    echo "#include \"$1.hh\"" >> $1.cc
} #}}}
# {{{ mkhx
function mkhx
{
    touch $1.hxx
    touch $1.hh

    chmod 640 $1.hxx
    chmod 640 $1.hh

    CAPS=`echo $1 | tr [a-z-] [A-Z_]`

    echo "#ifndef $CAPS"_HH_ >> $1.hh
    echo "# define $CAPS"_HH_ >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo "# include \"$1.hxx\"" >> $1.hh
    echo "#endif /* !$CAPS""_HH_ */" >> $1.hh


    echo "#ifndef $CAPS"_HXX_ >> $1.hxx
    echo "# define $CAPS"_HXX_ >> $1.hxx
    echo "# include \"$1.hh\"" >> $1.hxx
    echo >> $1.hxx
    echo >> $1.hxx
    echo >> $1.hxx
    echo "#endif /* !$CAPS""_HXX_ */" >> $1.hxx
} # }}}
# {{{ gify (Mov to Gif)
gify() {
  if [[ -n "$1" && -n "$2" ]]; then
    ffmpeg -i $1 -pix_fmt rgb24 temp.gif
    convert -layers Optimize temp.gif $2
    rm temp.gif
  else
    echo "proper usage: gify <input_movie.mov> <output_file.gif>. You DO need to include extensions."
  fi
} # }}}
# {{{ colors ?
# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Copied from http://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

# }}}
#{{{ web_search
function web_search()
{
    local open_cmd
    if [[ $(uname -s) == 'Darwin' ]]; then
        open_cmd='open'
    else
        open_cmd='xdg-open'
    fi


    if [[ ! $1 =~ '(google|bing|yahoo|duckduckgo)' ]];
    then
        echo "Search engine $1 not supported."
        return 1
    fi

    local url="http://www.$1.com"


    if [[ $# -le 1 ]]; then
        $open_cmd "$url"
        return
    fi
    if [[ $1 == 'duckduckgo' ]]; then

        url="${url}/?q="
    else
        url="${url}/search?q="
    fi
    shift

    while [[ $# -gt 0 ]]; do
        url="${url}$1+"
        shift
    done

    url="${url%?}"

    $open_cmd "$url"
}


alias bing='web_search bing'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'

alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

#}}}
# # {{{ Colors for man
# man()
# {
#     env \
#         LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#         LESS_TERMCAP_md=$(printf "\e[1;31m") \
#         LESS_TERMCAP_me=$(printf "\e[0m") \
#         LESS_TERMCAP_se=$(printf "\e[0m") \
#         LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#         LESS_TERMCAP_ue=$(printf "\e[0m") \
#         LESS_TERMCAP_us=$(printf "\e[1;32m") \
#         man "$@"
# }
# #}}}
# {{{ how_do_i_prettyfact?
function how_do_i_prettyfact?
{
    echo ez:
    echo 'static void prettyfact(int n)'
    echo '{ if (n == 1) throw 1; try { prettyfact (n-1); } catch (int i) { throw i*n; } }'
    echo 'int fact (int n)'
    echo '{ try { prettyfact (n); } catch (int ret) { return ret; } return 0; }'
}
# }}}
# {{{ tips
function tips
{
    echo 'import code; code.interact(local = locals())'
    echo "ethtool -p eth0 # Blink eth0\'s LED so you can find it in the rat\'s next of server cables. Ctrl-C to stop. Thanks"
    echo 'while :; do echo wub wub wub | espeak --stdout | play - pitch -400 bend .3,-600,.3 ; done # CLI generated dubstep. Thx @Butter_Tweets'
    echo 'quemu -noshotdown -noreboot'
}
# }}}
# {{{ whatdo
function whatdo
{
    echo ''
}
# }}}
# }}}
# {{{ Sft
. ~/sft/z/z.sh
# }}}
# {{{ gyro
alias SIGC='source /opt/clanton-tiny/1.4.2/environment-setup-i586-poky-linux-uclibc'
alias sshg='ssh root@192.168.112.113'
scpg() {scp $1 root@192.168.112.112:}
alias -g IG='192.168.112.112'
alias dpl='scp -r ~/gyro/gyro/src/wifi.cc root@192.168.112.113:'
alias dce='scp -r ~/gyro/gyro/src/wifi.cc root@192.168.112.113: && ssh root@192.168.112.112 "g++ wifi.cc && ./a.out"'
lg()
{
  scp -r ~/gyro/gyro_wifi/src/wifi.cc root@192.168.112.112:gyro_wifi/src && ssh root@192.168.112.112 'make -C gyro_wifi && ./gyro_wifi/wifi'
}
# }}}
# {{{ Kaneton
# export KANETON_USER="group30"
# export KANETON_USER="my_test"
# export KANETON_HOST="linux/ia32"
# export KANETON_PLATFORM="ibm-pc"
# export KANETON_ARCHITECTURE="ia32/educational"
# export KANETON_PYTHON="/usr/bin/python"
# function kcc
# {
#   gcc -c $1 -o bootsect.o &&
#   ld bootsect.o -o bootsect --oformat binary -Ttext 0x7c00 &&
#   qemu-system-i386 -fda bootsect
# } # target remote : 1234, add-symbol-file ex.0 0x7c00, b _start c layout source 

# alias pewad='pwd'
# alias kmake='cd ~/k && make && make build && make install'
# alias ktest='KANETON_USER=my_test && cd ~/k && make && make build && \
# make install && cd - && qemu -fda \
# /home/yaon/k/environment/profile/user/my_test/my_test.img'
# alias kqdb='qemu-system-i386 -fda /home/yaon/k/environment/profile/user/my_test/my_test.img -s -S &'
# alias kgdb='gdb /home/yaon/k/kaneton/kaneton -tui' #target remote :1234
# }}}
alias get='curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET localhost:8888'
post() {
  curl -H "Authorization: GoogleLogin auth=<<YOUR_TOKEN>>" \
    -X POST \
    -H "Content-type: application/json" \
    -d '{"test":"taist"}' \
    'localhost:8888'
}
alias chu='chromium --disable-web-security 2>/dev/null &'
alias ch='google-chrome --disable-web-security 2>/dev/null &'
alias ctagsjs='ctags -R --exclude=node_modules --exclude=lib --exclude=tasks --exclude=bower_components'
alias dualVB='xrandr --output VBOX0 --below VBOX1 '
alias dual='xrandr --output LVDS1 --below DP1'
alias agn='ag --ignore-dir=node_modules --ignore-dir=bower_components --ignore-dir=dist --ignore-dir=coverage --ignore-dir=vendor'
alias gg='grunt serve'
alias ar='vim ~/.config/awesome/rc.lua'
alias CAPS="xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"
alias l='xtrlock'
alias wifi-client='wicd-client'
alias music='ncmpcpp'
alias go_to_sleep='sudo /etc/acpi/sleep.sh force'
applets () {
    nm-applet &
    skype &
    steam &
}
alias chd="chromium-browser --disable-web-security &"
alias hibernate="sudo su -c 'sudo echo -n disk > /sys/power/state'"
alias gnp='git config --global credential.helper cache && git config --global credential.helper "cache --timeout=360000"'
alias gyp='git config --global credential.helper cache && git config --global credential.helper "cache --timeout=0"'

# git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

# React native
export ANDROID_HOME='/home/jim/sft/android-sdk-linux'
export PATH=${PATH}:/home/jim/sft/android-sdk-linux/tools
export PATH=${PATH}:/home/jim/sft/android-sdk-linux/platform-tools
alias start_pikit='mvn spring-boot:run -Plocal -Dspring.profiles.active=local,nosslchecking -Dspring.config.location=/home/jim/Carrefour-Pikit/pikit-docs/properties/pikit-hub-rest/'
alias stx='setxkbmap us -variant altgr-intl'
alias idea='./sft/idea-IC-143.382.35/bin/idea.sh &'
eval $(thefuck --alias)
alias partyhard='curl -k https://mariaux.org/party-hard.pl | perl &'
alias adb_restart='sudo /home/jim/sft/android-sdk-linux/platform-tools/adb kill-server && /home/jim/sft/android-sdk-linux/platform-tools/adb start-server'

alias rn_logs='adb logcat *:S ReactNative:V ReactNativeJS:V'
alias rn_start_fix='echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p'
