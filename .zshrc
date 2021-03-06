autoload -Uz zmv
autoload -U compinit
compinit
autoload -Uz vcs_info
autoload colors
colors

### 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

### MSYS2 でマウントした C: 上でも補完を有効にする
drives=$(mount | sed -rn 's#^[A-Z]: on /([a-z]).*#\1#p' | tr '\n' ' ')
zstyle ':completion:*' fake-files /: "/:$drives"
unset drives

### 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt HIST_IGNORE_SPACE	# 先頭にスペースをつけると履歴に記録しない
setopt hist_ignore_dups
setopt share_history

### 雑多な設定

# ディレクトリ名で cd
setopt auto_cd

# PROMPT変数内で変数参照
setopt prompt_subst

### 環境変数
export LANG=ja_JP.UTF-8
export EDITOR=vim

### エイリアス
alias ls='ls -v --color=auto'
alias ll='ls -lv --color=auto'
alias la='ls -Av --color=auto'
alias lla='ls -lAv --color=auto'
alias vi=vim

# git
alias gipul='git pull origin master'
alias gipsh='git push origin master'
alias gico='git commit -am'

# zzl
alias mkproj='mkproj.cmd'
alias mkwebconf='mkwebconf.cmd'

### バージョン管理システムから情報を取得
### http://www.sirochro.com/note/terminal-zsh-prompt-customize/
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

precmd () { vcs_info }

### プロンプトの設定
PROMPT=$'
%{\e[38;5;042m%}[%~]%{\e[m%}${vcs_info_msg_0_}%{\e[38;5;042m%}%#%{\e[m%} '
