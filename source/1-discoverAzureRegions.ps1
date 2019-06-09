##
## example: get Azure regions and logon service URLs 
##

$discoverAzureRegionsURL = "https://login.microsoftonline.com/common/discovery/instance?api-version=1.1&authorization_endpoint=https://login.microsoftonline.com/common/oauth2/authorize";
$res = Invoke-WebRequest -Uri $discoverAzureRegionsURL

write-host "Azure Regions results"
$res | fl

# get response content
$rescontent = $res.Content | ConvertFrom-Json

# wait
$pressAnyKey = read-host "press any key"

# get metadata table 
$regions_mapping = $rescontent.metadata

$regions_mapping | fl

# wait
$pressAnyKey = read-host "press any key"

