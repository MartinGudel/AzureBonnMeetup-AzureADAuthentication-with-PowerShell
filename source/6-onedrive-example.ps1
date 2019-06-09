##
##
##

# $idOrUserPrincipalName = "powershelldemo@teamsplayer.de"
$idOrUserPrincipalName = "martin.gudel@wizardofapps.de"

# $resource = "https://graph.microsoft.com/v1.0/users/$idOrUserPrincipalName/drive"
$resource = "https://graph.microsoft.com/v1.0/users/me/drive"

$header = @{'Authorization' = ("Bearer $token")}
$body = $null
$result = Invoke-RestMethod -Uri $resource -Headers $header -Method GET -ContentType "application/json"  -Verbose

# get drive fÃ¼r Abneleil708@themigrationwizard.onmicrosoft.com
$sourceUser = "powershelldemo@teamsplayer.de"
$sourceResource = "https://graph.microsoft.com/v1.0/users/$sourceUser/drive/root"
$sourceRoot = Invoke-RestMethod -Uri $sourceResource -Headers $header -Method GET -ContentType "application/json"  -Verbose

##
## get all my notebooks
## 
$header = @{Authorization = ("Bearer "+$token)} 

$allmynotebooks = Invoke-RestMethod -Uri https://graph.microsoft.com/v1.0/me/onenote/notebooks -Headers $header -Method GET -ContentType "application/json"   -Verbose

