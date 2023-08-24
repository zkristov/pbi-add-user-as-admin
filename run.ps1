#Requires -Modules @{ ModuleName="MicrosoftPowerBIMgmt"; ModuleVersion="1.2.1111" }

param(
    $upn = "admin@contoso.onmicrosoft.com",
    $ids =  @() #@("3145b420-c4f9-44c4-8b95-89f6e56e594f")
)

$ErrorActionPreference = "Stop"
$VerbosePreference = "SilentlyContinue"

try {
    # login to the Power BI service using a Fabric admin account
    Connect-PowerBIServiceAccount

    # get all Power BI workspaces on the tenant
    $workspaces = Get-PowerBIWorkspace -Scope Organization -All

    Write-Host "Total Workspaces: $($workspaces.Count)"

    # filter workspace: only v2 workspaces, active, & premium workspaces
    $workspaces = @($workspaces | Where-Object {$_.type -eq "Workspace" -and $_.state -eq "Active" -and $_.IsOnDedicatedCapacity -eq $true})

    # filter workspaces by workspace ids (for testing purposes only)
    if ($ids -and $ids.Count -gt 0)
    {
        $workspaces = @($workspaces | Where-Object { $ids -contains $_.Id})
    }

    # remove workspaces that already have the target account assigned as an admin
    $workspaces = $workspaces | Where-Object { 
        
        $members = @($_.users | Where-Object { $_.identifier -eq $upn -and $_.accessRight -eq "Admin"})

        if ($members.Count -eq 0) 
        {
            $true
        }
        else
        {
            $false
        }
    }

    Write-Host "Target Workspaces: $($workspaces.Count)"

    # iterate through filtered workspaces  
    foreach ($workspace in $workspaces) {
        Write-Host "    - Adding $($upn) as admin to workspace: $($workspace.name) ($($workspace.id))"
        
        # format request body
        $body = @{
            "emailAddress" = $upn;
            "groupUserAccessRight" = "Admin"
        }
        # convert request body to json string
        $bodyStr = ($body | ConvertTo-Json)

        # send Power BI REST API request to add user as admin
       Invoke-PowerBIRestMethod -method Post -url "admin/groups/$($workspace.id)/users" -body $bodyStr
    }
}
catch {
    # display last known Power BI error message
    Resolve-PowerBIError -Last
}
finally {
    # disconnect from the Power BI service
    Disconnect-PowerBIServiceAccount
}