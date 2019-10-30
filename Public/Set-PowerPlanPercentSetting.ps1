Function Set-PowerPlanPercentSetting
{
    <#
        .SYNOPSIS
          Set the percentage, between 1 and 100, of a power setting that uses a percentage as it's value. (EX: the "Critical Battery Level")
          Setting requires a value starting with 1 and up to 100.  
        
        .DESCRIPTION
          Set the percentage, between 1 and 100, of a power setting that uses a percentage as it's value. (EX: the "Critical Battery Level")
          Setting requires a value starting with 1 and up to 100.  

        .PARAMETER PowerSettingPercent
          Specify the specific percent (between 1 and 100) that you'd like to set the power setting to. 
        
        .PARAMETER SettingObject
          Specify the power setting object.  This can be passed to it directly with Get-PowerPlanSettingValue or by storing 
          the output object of Get-PowerPlanSettingValue in a variable.
        
        .EXAMPLE
          Set-PowerPlanPercentSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) `
          -InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Critical battery level")) -PowerSettingPercent 5

          Sets the critical battery level percentage to 5%.
    
        .NOTES
          NAME    : Set-PowerPlanPercentSetting
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : October 30, 2019 
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory = $True
        )]
        [ValidateRange(1,100)]
        [string]$PowerSettingPercent,
        [object]$SettingObject
    )
    
    $SettingObject | Set-CimInstance -Property @{SettingIndexValue = [int]$PowerSettingPercent}
    $SettingObject
}

Export-ModuleMember -Function Set-PowerPlanPercentSetting