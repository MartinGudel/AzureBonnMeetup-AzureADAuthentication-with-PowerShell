##
## example: straight forward authentication by using grant-type password 
## 
# based on https://docs.microsoft.com/de-de/onedrive/developer/rest-api/?view=odsp-graph-online

# # client_id und client_secret aus der AzureAD App Registration ablesen
$client_id     = '36f8e707-f066-44dd-bb26-41ea48517546'   
$client_secret = 'SJ3C1Uiva3zzYDHJ4vRv/fk17iHaIvLolN9VHpbYi9s='
$redirectUrl   = 'https://localhost/'

# 
$tokenendpoint = 'https://login.microsoftonline.com/7e74f584-86e6-4965-a7d5-05fd320f6c55/oauth2/token'
$username = "powershelldemo@teamsplayer.de"
$password = 'S0lv3The1ssue'

$api = 'https://graph.microsoft.com/'

$AuthorizationPostRequest = "grant_type=password" + "&" +
                                "username=" + $username + "&" +
                                "password=" + $password + "&" +
                                "redirect_uri=" + [System.Web.HttpUtility]::UrlEncode($redirectUrl) + "&" +
                                "client_id=$client_id" + "&" +
                                "client_secret=" + [System.Web.HttpUtility]::UrlEncode("$client_secret") + "&" +
                                "resource=" + [System.Web.HttpUtility]::UrlEncode($api)

$Authorization = Invoke-RestMethod -Method Post `
                        -ContentType application/x-www-form-urlencoded `
                        -Uri  $tokenendpoint `
                        -Body $AuthorizationPostRequest

write-host "if the password is spelled correctly, we now will see an JSON Web Token"
$Authorization | fl 

# explained: JSON Web Tokens, industry standard RFC 7519 
# view content by using https://jwt.io/

$pressAnyKey = read-host "press any key"

$Token = $Authorization.access_token

$idOrUserPrincipalName = "powershelldemo@teamsplayer.de"
$resource = "https://graph.microsoft.com/v1.0/users/$idOrUserPrincipalName/drive"

$header = @{'Authorization' = ("Bearer $token")}
$body = $null
$result = Invoke-RestMethod -Uri $resource -Headers $header -Method GET -ContentType "application/json"  -Verbose

# get drive fÃ¼r Abneleil708@themigrationwizard.onmicrosoft.com
$sourceUser = "powershelldemo@teamsplayer.de"
$sourceResource = "https://graph.microsoft.com/v1.0/users/$sourceUser/drive/root"
$sourceRoot = Invoke-RestMethod -Uri $sourceResource -Headers $header -Method GET -ContentType "application/json"  -Verbose

