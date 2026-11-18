[ -x ~/wsl2-ssh-agent ] && eval $(~/wsl2-ssh-agent)

export PATH="$HOME/.local/bin:$PATH"

eval "$(mise activate zsh)"

# dotfiles の置き場所はマシンごとに違う（ghq はマシンによって無い）ので、
# ~/.zshrc のシンボリックリンクの先からリポジトリを引く
dotup() {
  local repo=${${:-$HOME/.zshrc}:A:h:h}
  if [[ ! -f $repo/mise.toml ]]; then
    echo "dotup: ~/.zshrc が dotfiles へのリンクではありません ($repo)" >&2
    return 1
  fi
  mise -C "$repo" run update
}

# 公開リポジトリに載せられないマシン固有の設定
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

## starshp
eval "$(starship init zsh)"
