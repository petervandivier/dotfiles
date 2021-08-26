#!/usr/bin/env pwsh
#

if($IsMacOS){
    . $PSScriptRoot/macos.profile.ps1
}

$Constants = @(
    @{
        Name = 'UTC' 
        Value = [TimeZoneInfo]::FindSystemTimeZoneById('UTC')
        Option = 'ReadOnly'
    },
    @{
        Name = 'UnixEpoch' 
        Value = ([DateTime]'1970-01-01').ToUniversalTime()
        Option = 'ReadOnly'
        Description = @(
            "Unix Epoch. Aliased to UE. Useful for the .AddSeconds() & .AddMilliseconds() methods "
            "to convert unix time given to you into a [DateTime] object. "
        ) -join "`n"
    },
    @{
        Name = 'DBOProps'
        Value = @('RowError','RowState','Table','ItemArray','HasErrors')
        Option = 'ReadOnly'
        Description = @(
            "https://github.com/sqlcollaborative/dbops "
            "When using Invoke-DboQuery, these are additional NoteProperty attributes "
            "supplied to the data frame. Use 'Invoke-DboQuery `$foo | Select -ExcludeProperty `$DBOProps' "
            "to exclude these attributes and capture _only_ the data columns. "
        ) -join "`n"
    },
    @{
        Name = 'ISODateTimeStringFormat'
        Value = 'yyyy-MM-ddThh:mm:ss.fffzz'
        Option = 'ReadOnly'
        Description = @(
            "I don't want to type it out every time I want a damned ISO Format Date string"
        ) -join "`n"
    }
)

foreach($Constant in $Constants) {
    New-Variable @Constant -Force
}

New-Variable -Name 'UE' -Value $UnixEpoch -Option:ReadOnly -Force
New-Variable -Name 'IsoFmt' -Value $ISODateTimeStringFormat -Option:ReadOnly -Force

$Aliases = @(
    @{Name='ctcsv'; Value='ConvertTo-Csv'}
    @{Name='ctj'; Value='ConvertTo-Json'}
    @{Name='cfj'; Value='ConvertFrom-Json'}
)

foreach($Alias in $Aliases){
    New-Alias @Alias -Force
}

Remove-Variable (
    'Alias',
    'Aliases',
    'Constant',
    'Constants'
)

. $PSScriptRoot/prompt.ps1
