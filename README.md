# Power BI - Add User As Admin To All Workspaces
This script iterates through Power BI Workspaces and adds a new admin user to each workspace.

Requires a user principal who is a [Power BI Tenant Admin](https://learn.microsoft.com/en-us/power-bi/admin/service-admin-role) to authenticate and call the Power BI Admin REST APIs.

## Instructions
Make sure you have the Powershell cmdlet [MicrosoftPowerBIMgmt](https://learn.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps) installed.

Within a Powershell terminal, execute `run.ps1 -upn "admin@contoso.onmicrosoft.com"` replacing admin@contoso.onmicrosoft.com with a valid user principal name.

## Notes
First, the script returns a list of all Power BI Workspaces associated to the authenticated user's tenant. It proceeds to filter the returned list of workspaces for only:  
  - Workspace v2  
  - Active (not orphaned or deleted)  
  - Hosted on a dedicated capacity (aka Power BI Premium)  

Next, it iterates through each workspace and adds the new user (see instruction #1) to the workspace as an admin.

## Testing
To test the script against a select number of Workspace(s), execute `run.ps1 -upn "admin@contoso.onmicrosoft.com" -ids "3145b420-c4f9-44c4-8b95-89f6e56e594f"` replacing "3145b420-c4f9-44c4-8b95-89f6e56e594f" with a valid Workspace id.

## Power BI REST APIs Reference
[Admin - Groups GetGroupsAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-get-groups-as-admin)  
[Admin - Groups AddUserAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-add-user-as-admin)

## Credit
Derived from Rui Romano's [PBIMonitor](https://github.com/RuiRomano/pbimonitor).