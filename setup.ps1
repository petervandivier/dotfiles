#Requires -RunAs
<# 
.LINK
    https://gist.github.com/LitKnd/93d02119cb10cef6992fd1bcddbdc73a
#> 

Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# for PowerShellGet
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# https://community.chocolatey.org/packages/wsl2
choco install wsl2 --params "/Version:2 /Retry:true" --yes

Restart-Computer
# https://dev.to/fharookshaik/get-started-with-wsl2-44
wsl --set-default-version 2
# https://wiki.ubuntu.com/WSL
# manual download from Windows Store is recommended
# from the ubuntu docs page, it looks like the chocolatey 
# install might even be overkill 🤔 

# https://community.chocolatey.org/packages/vagrant
choco install vagrant --yes

Restart-Computer

# https://community.chocolatey.org/packages/virtualbox
choco install virtualbox --params "/NoDesktopShortcut" --yes

# https://community.chocolatey.org/packages/chefdk
choco install chefdk --yes

# https://community.chocolatey.org/packages/ruby
choco install ruby --yes

# https://community.chocolatey.org/packages/slack
choco install slack --yes

# # https://community.chocolatey.org/packages/terminals
# choco install terminals --yes

# https://community.chocolatey.org/packages/treesizefree
choco install treesizefree --yes

# https://community.chocolatey.org/packages/crystaldiskmark
choco install crystaldiskmark --yes

# repeated fails to find ffmpeg on $PATH 
# just gonna use web app until debug or fix
# # https://community.chocolatey.org/packages/WhatsApp
# choco install whatsapp --yes
# Remove-Item ~/Desktop/WhatsApp.lnk -ErrorAction SilentlyContinue

# https://community.chocolatey.org/packages/powershell-core
choco install powershell-core --pre `
    --install-arguments='"REGISTER_MANIFEST=1 ENABLE_PSREMOTING=1"' `
	--yes

# https://community.chocolatey.org/packages/microsoft-windows-terminal
choco install microsoft-windows-terminal --pre --yes

# https://community.chocolatey.org/packages/sql-server-management-studio
choco install sql-server-management-studio --yes

# https://community.chocolatey.org/packages/SqlToolbelt
choco install sqltoolbelt --params "/products:'SQL Prompt'" --yes

# https://community.chocolatey.org/packages/drawio
choco install drawio --yes

# https://community.chocolatey.org/packages/vscode
choco install vscode --yes

# https://community.chocolatey.org/packages/vscode-powershell
choco install vscode-powershell --yes

# https://community.chocolatey.org/packages/vscode-mssql
choco install vscode-mssql --yes

# https://community.chocolatey.org/packages/SublimeText4
choco install sublimetext4 --pre --yes
# TODO: install powershell ext

# https://community.chocolatey.org/packages/obs-studio
choco install obs-studio --yes

# https://community.chocolatey.org/packages/git
choco install git.install `
    --params "/GitAndUnixToolsOnPath /SChannel /NoAutoCrlf /NoGuiHereIntegration" `
    --yes

<#
TODO: debug this automation

    New-Item -Type Directory -Path "${HOME}/.ssh" -Force | Out-Null
    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    # https://unix.stackexchange.com/a/69318/automated-ssh-keygen-without-passphrase-how
    # https://superuser.com/a/1004263/how-can-i-change-the-directory-that-ssh-keygen-outputs-to
    # https://manpages.ubuntu.com/manpages/xenial/man1/ssh-keygen.1.html
    ssh-keygen `
        -t ed25519 `
        -C "petervandivier@gmail.com" `
        -f "${HOME}/.ssh/petervandivier@github.id_ed25519" `
        -N """"
    
    Get-Service -Name ssh-agent | Set-Service -StartupType Manual
#>

# https://community.chocolatey.org/packages/nordvpn
choco install nordvpn --yes

# https://community.chocolatey.org/packages/jq
choco install jq --yes

# https://community.chocolatey.org/packages/azure-cli
choco install azure-cli --yes

# https://community.chocolatey.org/packages/postgresql
$pw = (New-Guid).Guid -replace '-',''
choco install postgresql --yes --params "/Password:$pw"
# bug in choco install - chosen pw not applied
Remove-Variable pw

# https://community.chocolatey.org/packages/windbg
# TODO: (last update 2016 - actively seeking maintainers)
# choco install windbg --yes -params '"/SymbolPath:D:\Symbols"'

# https://community.chocolatey.org/packages/PowerBI
# TODO: (checksum mismatch fail)
# choco install powerbi --yes

# https://4sysops.com/wiki/how-to-install-the-powershell-active-directory-module/
# https://www.microsoft.com/en-us/download/details.aspx?id=45520
#   WindowsTH-RSAT_WS_1803-x64.msu
#   Update for Windows (KB2693643)
# https://community.chocolatey.org/packages/RSAT
# choco install rsat -params '"/AD"' --yes

# https://answers.microsoft.com/en-us/windows/forum/windows_10-start/how-to-enable-numlock-key-in-windows-10/842a33f4-6389-4e2e-939b-a0cca6aff353?page=7
# https://pscustomobject.github.io/powershell/PowerShell-Export-Registry-Key/
# https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/reg-export
New-Item -ItemType Directory -Path C:\Temp -Force | Out-Null
$initRegKey = "C:\Temp\init_HKU#.DEFAULT#Control Panel#Keyboard.reg"
$updRegKey = "C:\Temp\enableNumPadOnBoot.reg"

reg export  "HKU\.DEFAULT\Control Panel\Keyboard" $initRegKey

(Get-Content $initRegKey) `
    -replace '\"InitialKeyboardIndicators\"=\"([0-9]*)\"', `
             '"InitialKeyboardIndicators"="2147483650"' | 
    Set-Content $updRegKey

reg import $updRegKey

# 
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Install-Module posh-git
Install-Module dbatools
Install-Module PSScriptAnalyzer
Install-Module ImportExcel
Install-Module powershell-yaml
# https://docs.microsoft.com/en-us/powershell/azure/install-az-ps#installation
Install-Module -Name Az `
    -Scope CurrentUser `
    -Repository PSGallery `
    -Force
;
Install-Module AzureRM.profile 
# https://docs.microsoft.com/en-us/powershell/power-bi/overview
# https://github.com/microsoft/powerbi-powershell
Install-Module -Name MicrosoftPowerBIMgmt
Install-Module Pester -Force
Install-Module PSFramework
Install-Module SqlCmd2
Install-Module OMSIngestionAPI

Import-Module dbatools

# enable SQL Server Agent
Invoke-DbaQuery -SqlInstance localhost -Query "
exec sp_configure 'show advanced options', 1;
reconfigure;
exec sp_configure 'agent xps', 1;
reconfigure;
"
Set-Service SQLSERVERAGENT -StartupType AutomaticDelayedStart

