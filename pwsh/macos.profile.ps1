#!/usr/bin/env pwsh
#

# remove to restore LibreSSL 2.8.3
$env:PATH = "/usr/local/opt/openssl@1.1/bin:${env:PATH}"
# For compilers to find openssl@1.1 you may need to set:
#   export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
#   export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
# For pkg-config to find openssl@1.1 you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

. $PSScriptRoot/nix.profile.ps1
