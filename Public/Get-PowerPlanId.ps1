Function Get-PowerPlanId
{
    <#
        .SYNOPSIS
          Get the ID of the of one of the powerplans on the computer.
        
        .DESCRIPTION
          Calls to the cim instance 'root\cimv2\power' via the Win32_PowerPlan class to gather the ID of the systems power plans.
         
        .PARAMETER Active
          Specify whether to choose the active or non-active power plan. 
          
        .EXAMPLE
          Get-PowerPlanId -Active:$True
          
          Returns the information of the active power plan.
          
        .EXAMPLE
          Get-PowerPlanId -Active:$False
          
          Returns the information of the non-active power plan. 
        
        .NOTES
          NAME    : Get-PowerPlanId
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : October 23, 2019
    #>
    [CmdletBinding()]
    Param
    (    
        [Parameter(
            Mandatory=$True
        )]
        [bool]$Active
    )

    if($Active)
    {
        ((Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerPlan | Where{ `
            $_.IsActive -eq $True
        }).InstanceID).Replace("Microsoft:PowerPlan\","")
    }
    else
    {
        ((Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerPlan | Where{ `
            $_.IsActive -eq $False
        }).InstanceID).Replace("Microsoft:PowerPlan\","")
    }
}

Export-ModuleMember -Function Get-PowerPlanId