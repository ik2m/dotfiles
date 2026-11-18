[ -x ~/wsl2-ssh-agent ] && eval $(~/wsl2-ssh-agent)

export PATH="$HOME/.local/bin:$PATH"

eval "$(mise activate zsh)"

# 公開リポジトリに載せられないマシン固有の設定
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

## starshp
eval "$(starship init zsh)"
