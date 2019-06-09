##
## example 2: get user realm
## 

# $username = "martin.gudel@wizardofapps.de"
# $username = "rene.delamotte@edoc.de"
# $username = "patrick.heyde@microsoft.com"
$username = "phantasiebenutzer@kramerundcrew.de"

$getUserRealmUri = "https://login.microsoftonline.com/common/userrealm/" + $username + "?api-version=1.0"

$res = invoke-webrequest -uri $getUserRealmUri

write-host "user realm for" $username
$res | fl 

# wait
$pressAnyKey = read-host "press any key"

$userDomainManagedFederated = $res.Content | ConvertFrom-Json

write-host "Azure AD Domain configuration" 
$userDomainManagedFederated | fl 

# wait
$pressAnyKey = read-host "press any key"
