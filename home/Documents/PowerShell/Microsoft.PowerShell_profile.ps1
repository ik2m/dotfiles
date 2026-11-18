# dotfiles の置き場所はマシンごとに違うので、
# $PROFILE のシンボリックリンクの先からリポジトリを引く
function dotup {
    $target = (Get-Item $PROFILE).ResolveLinkTarget($true)
    $repo = if ($target) { $target.Directory.Parent.Parent.Parent.FullName }
    if (-not $repo -or -not (Test-Path (Join-Path $repo 'mise.toml'))) {
        Write-Error "`$PROFILE が dotfiles へのリンクではありません ($PROFILE)"
        return
    }
    mise -C $repo run update
}

# 公開リポジトリに載せられないマシン固有の設定
$localProfile = Join-Path (Split-Path $PROFILE) 'Microsoft.PowerShell_profile.local.ps1'
if (Test-Path $localProfile) { . $localProfile }
Remove-Variable localProfile

Invoke-Expression (&starship init powershell)
