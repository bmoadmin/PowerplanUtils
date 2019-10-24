Function Get-PowerPlanSettingId
{
    <#
        .SYNOPSIS
          Retrieve the instanceId of a specific power setting available on the computer.  
          
        .DESCRIPTION
          Make a call via cim to "root\cimv2\power" using the Win32_PowerSetting class to pull the ID for a specific power plan setting.
        
        .PARAMETER Name
          Specify the name of the power setting you'd like to retrieve the ID of. This field is required.
        
        .EXAMPLE
          Get-PowerPlanSettingId -Name "Low battery action". By default all power plan settings will output to stdout.
          
          Retrieves all information about the power setting named low battery action. Output should look like below:
            
          {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
            
        .NOTES
          NAME    : Get-PowerPlanSettingId
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : October 24, 2019
    #>
    [CmdletBinding()]
    Param
    ( 
        [Parameter(
            Mandatory=$True
        )]
        [string]$Name
    )
    # Try catch not working as if there's no match the try block continues silently 
    Try
    {
        ((Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSetting | Where{ `
            $_.ElementName -eq "$Name"
        }).InstanceID).Replace("Microsoft:PowerSetting\","")      
    }
    Catch
    {
        Throw "Couldn't retrieve a powerplan setting for $Name"
    }
}