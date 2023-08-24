# Power BI - Add User As Admin To All Premium Workspaces
This script iterates through all Power BI Premium workspaces and adds a new admin user to each workspace.

*Requires an authenticated user principal who is a [Fabric Service Admin](https://learn.microsoft.com/en-us/power-bi/admin/service-admin-role) to call the Power BI Admin REST APIs.

## Instructions
Make sure you have the Powershell cmdlet [MicrosoftPowerBIMgmt](https://learn.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps) installed.

Within a Powershell terminal, execute `run.ps1 -upn "admin@contoso.onmicrosoft.com"` replacing "admin@contoso.onmicrosoft.com" with a valid user principal name.

## Testing
To test the script against a select number of Workspace(s), execute `run.ps1 -upn "admin@contoso.onmicrosoft.com" -ids "3145b420-c4f9-44c4-8b95-89f6e56e594f"` replacing "3145b420-c4f9-44c4-8b95-89f6e56e594f" with a valid Workspace id. Note: You can pass more than one worksapce id using a comma seperated list of ids.

## Notes
The [Admin - Groups AddUserAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-add-user-as-admin) endpoint has a throttle limitation of 200 requests per hour. The script will error with an [HTTP - 429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429) error when throttling has occured.

## Power BI REST APIs Reference
[Admin - Groups GetGroupsAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-get-groups-as-admin)  
[Admin - Groups AddUserAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-add-user-as-admin)

## Credit
Derived from Rui Romano's [PBIMonitor](https://github.com/RuiRomano/pbimonitor).
