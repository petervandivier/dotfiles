#!/usr/bin/env pwsh
#

# don't highjack unix executables (but ¿do highjack? _some_ builtins)
# (Get-Alias).Name | awk '{print $1}' | % {which $_}
Remove-Alias -Force (
    # 'cd', # https://unix.stackexchange.com/q/50058/348605 https://unix.stackexchange.com/questions/354123/what-is-usr-bin-cd?noredirect=1&lq=1
    'fc', # ReadOnly pwsh alias
    'echo',
    'history', # falls back to Get-History even w/o explicit alias ¯\_(ツ)_/¯
               # apparently pwsh with try to prepend "Get-" to things that
               # look like they want to be tokenised but don't have verbs
               # [citation needed]
    'pwd',
    'ri', # ReadOnly pwsh alias
    'type'
) -ErrorAction SilentlyContinue
